//
//  ContentModel.swift
//  LearningApp
//
//  Created by Ernest Margariti on 1/4/23.
//

import Foundation

class ContentModel: ObservableObject {
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //Current Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current Question
    @Published var currentQ: Question?
    var currentQIndex = 0
    
    //Current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    //Current Selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    
    init() {
        getLocalData()
    }
    // MARK: Data Methods
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            // TODO log error
            print("Couldn't parse local data")
        }
        
        //Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            //Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch {
            //Log error
            print("Could not parse style data")
        }
    }
    
    // MARK: Module navigation methods
    func beginModule(_ moduleid:Int) {
        //Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                //Found the matching module
                currentModuleIndex = index
                break
            }
        }
        //Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    //Clicking into a lesson
    func beginLesson (lessonIndex: Int) {
        //Check that the lsson index is within range of module lesson
        if lessonIndex < currentModule!.content.lessons.count {
                        currentLessonIndex = lessonIndex
                    }
        else {
            currentLessonIndex = 0
    }
        //Set the current lesson
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func hasNextLesson() -> Bool {
        //The following will return either a true or false statement
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleid: Int) {
        //Set the current module
        beginModule(moduleid)
        
        //If there are questions, set the current question to the first one
        currentQIndex = 0
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQ = currentModule!.test.questions[currentQIndex]
            //Set the question content
            codeText = addStyling(currentQ!.content)
        }
    }
    
    func nextLesson() {
        //Advance the lesson index
        currentLessonIndex += 1
        //Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            //Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            //Reset the lesson state
            currentLesson = nil
            currentLessonIndex = 0
            
        }
    }
    //MARK: Code Styling
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data
        if styleData != nil {
            data.append(self.styleData!)
        }
        //Add the html data
        data.append(Data(htmlString.utf8))
        //Convert to attributed string
        //Technique 1
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                resultString = attributedString
            
        }
        catch {
            print("Could not turn html into attributed string")
        }
        
        //Technique 1 could also be written as below (does not throw error, will just skip over error in the following technique)
        
//        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//        resultString = attributedString
            
        return resultString
    }
    
    
}

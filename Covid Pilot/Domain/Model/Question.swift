//
//  Question.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

enum QuestionType {
    case Rate
    case SingleSelect
    case MultiSelect
    case Text
}

class Question {
    public var _id: Int?
    public var type: QuestionType?
    public var question: String?
    public var options: [QuestionOption]?
    public var minValue: Int?
    public var maxValue: Int?
    public var mandatory: Bool?
    public var position: Int?
    public var childPosition: Int?
    public var parent: Int?
    public var parentOption: Int?
    public var valuesSelected: [Any?]?
    
    init() {
        
    }
    
    init(type: QuestionType, question: String, minValue: Int?, maxValue: Int?) {
        self.type = type
        self.minValue = minValue
        self.maxValue = maxValue
        self.question = question
    }
    
    func getSelectedOption() -> QuestionOption? {
        for option in options ?? [] {
            if option.selected ?? false {
                return option
            }
        }
        return nil
    }
    
    func isChild() -> Bool {
        parent != nil
    }
}

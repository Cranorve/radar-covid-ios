//
//  Question.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

enum QuestionType: Int {
    case Rate = 4
    case SingleSelect = 3
    case MultiSelect = 2
    case MultiSelect2 = 1
}

class Question {
    public var _id: Int?
    public var type: QuestionType?
    public var question: String?
    public var options: [QuestionOption]?
    public var minValue: Int?
    public var maxValue: Int?
    public var mandatory: Bool?
    public var valuesSelected: [Any?]?
    
    init() {
        
    }
    
    init(type: QuestionType, question: String, minValue: Int?, maxValue: Int?) {
        self.type = type
        self.minValue = minValue
        self.maxValue = maxValue
        self.question = question
    }
}

//
//  Question.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

enum QuestionType: Int {
    case Rate = 0
    case SingleSelect = 1
    case MultiSelect = 2
}

struct Question {
    public var _id: Int?
    public var type: QuestionType?
    public var question: String?
    public var options: [QuestionOption]?
    public var minValue: Int?
    public var maxValue: Int?
    public var mandatory: Bool?
}

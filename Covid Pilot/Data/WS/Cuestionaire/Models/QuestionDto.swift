//
// QuestionDto.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct QuestionDto: Codable {

    public var _id: Int?
    public var order: Int?
    public var question: String?
    public var questionType: Int?
    public var options: [QuestionOptionDto]?
    public var minValue: Int?
    public var maxValue: Int?
    public var mandatory: Bool?

    public init(_id: Int?, order: Int?, question: String?, questionType: Int?, options: [QuestionOptionDto]?, minValue: Int?, maxValue: Int?, mandatory: Bool?) {
        self._id = _id
        self.order = order
        self.question = question
        self.questionType = questionType
        self.options = options
        self.minValue = minValue
        self.maxValue = maxValue
        self.mandatory = mandatory
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case order
        case question
        case questionType
        case options
        case minValue
        case maxValue
        case mandatory
    }

}


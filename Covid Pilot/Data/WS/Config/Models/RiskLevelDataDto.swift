//
// RiskLevelDataDto.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct RiskLevelDataDto: Codable {

    public var riskLevelValue1: Int?
    public var riskLevelValue2: Int?
    public var riskLevelValue3: Int?
    public var riskLevelValue4: Int?
    public var riskLevelValue5: Int?
    public var riskLevelValue6: Int?
    public var riskLevelValue7: Int?
    public var riskLevelValue8: Int?
    public var riskLevelWeight: Double?

    public init(riskLevelValue1: Int?, riskLevelValue2: Int?, riskLevelValue3: Int?, riskLevelValue4: Int?, riskLevelValue5: Int?, riskLevelValue6: Int?, riskLevelValue7: Int?, riskLevelValue8: Int?, riskLevelWeight: Double?) {
        self.riskLevelValue1 = riskLevelValue1
        self.riskLevelValue2 = riskLevelValue2
        self.riskLevelValue3 = riskLevelValue3
        self.riskLevelValue4 = riskLevelValue4
        self.riskLevelValue5 = riskLevelValue5
        self.riskLevelValue6 = riskLevelValue6
        self.riskLevelValue7 = riskLevelValue7
        self.riskLevelValue8 = riskLevelValue8
        self.riskLevelWeight = riskLevelWeight
    }


}

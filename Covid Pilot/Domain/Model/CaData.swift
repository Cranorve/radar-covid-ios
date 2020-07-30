//
//  CaData.swift
//  Covid Pilot
//
//  Created by alopezh on 29/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

struct CaData: Codable {
    
    public var id: String?
    public var description: String?
    
    public var phone: String?
    public var email: String?
    public var web: String?
    public var additionalInfo: String?

    public init(id: String?, description: String?, phone: String?, email: String?, web: String?, additionalInfo: String?) {
        self.id = id
        self.description = description
        self.phone = phone
        self.email = email
        self.additionalInfo = additionalInfo
        self.web = web
    }
    
}

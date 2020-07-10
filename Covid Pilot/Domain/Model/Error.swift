//
//  Error.swift
//  Covid Pilot
//
//  Created by alopezh on 06/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

enum DomainError: String, Codable, Swift.Error {
    case NotAuthorized
    case BluetoothTurnedOff
    case Unexpected
}

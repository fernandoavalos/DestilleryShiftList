//
//  Shift.swift
//  Destillery
//
//  Created by Fernando Avalos on 10/02/22.
//

import Foundation

struct Shift: Codable {
    var role: String
    var name: String
    var startDate: Date
    var endDate: Date
    var color: String
    
    enum CodingKeys: String, CodingKey {
        case role
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case color
    }
}

struct APIResult: Codable {
    var shifts: [Shift]
}

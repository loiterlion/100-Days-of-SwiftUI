//
//  Student.swift
//  Bookworm
//
//  Created by Bruce Wang on 2024/1/4.
//

import SwiftData
import Foundation

@Model
class Student {
    var id: UUID
    var firstName: String
    var lastName: String
    
    init(id: UUID, firstName: String, lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}

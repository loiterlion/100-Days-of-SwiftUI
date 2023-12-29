//
//  Habit.swift
//  HabitTracker
//
//  Created by Bruce Wang on 2023/12/29.
//

import Observation
import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var description: String
    var finishCount: Int
    
    init(title: String, description: String, finishCount: Int) {
        self.title = title
        self.description = description
        self.finishCount = finishCount
    }
}

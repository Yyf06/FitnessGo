//
//  StepModel.swift
//  FitnessGo
//
//  Created by Yufei Yao on 28/9/2024.
//

import SwiftUI


// NOTE:
// This is back_up function for manually exported health data.
// not in use if health api is availiable.


struct StepCountData: Identifiable {
    let id = UUID()
    let date: Date
    let stepCount: Double
}

func parseCSV(contents: String) -> [StepCountData] {
    var stepCounts: [StepCountData] = []
    let rows = contents.components(separatedBy: "\n")
    
    for row in rows.dropFirst() {
        let columns = row.components(separatedBy: ",")
        guard columns.count >= 2 else { continue }
        
        let dateString = columns[0].trimmingCharacters(in: .whitespacesAndNewlines)
        let stepCountString = columns[1].trimmingCharacters(in: .whitespacesAndNewlines)
  
        guard let stepCount = Double(stepCountString) else {
            continue
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        

        if let date = dateFormatter.date(from: dateString) {
            stepCounts.append(StepCountData(date: date, stepCount: stepCount))
        }
    }
    return stepCounts
}


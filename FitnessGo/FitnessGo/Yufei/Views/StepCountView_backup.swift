//
//  StepCountView.swift
//  FitnessGo
//
//  Created by Yufei Yao on 28/9/2024.
//

import SwiftUI


// back_up function for manually exported health data.
// not in use if health api is availiable.


struct StepCountView: View {
    @State private var stepCounts: [StepCountData] = []

    var body: some View {
        List(stepCounts) { stepCount in
            HStack {
                Text("\(stepCount.date, formatter: dateFormatter)")
                Spacer()
                Text("\(stepCount.stepCount, specifier: "%.0f")")
            }
        }
        .onAppear {
            loadCSVData()
        }
    }

    private func loadCSVData() {
        if let filePath = Bundle.main.path(forResource: "Step_Count", ofType: "csv") {
            do {
                let contents = try String(contentsOfFile: filePath)
                stepCounts = parseCSV(contents: contents)
            } catch {
                print("Error loading CSV file: \(error)")
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}


#Preview {
    StepCountView()
}

//
//  stepRead.swift
//
//  Created by Yufei Yao on 4/10/2024.
//

import SwiftUI
import HealthKit

// manages health-related data retrieval from HealthKit
class StepCountManager: ObservableObject {
    @EnvironmentObject var globalEnv: GlobalEnvironment
    private let healthStore = HKHealthStore()
    @Published var stepCount: Int = 0
    @Published var sleepHours: Double = 0
    @Published var runningDistance: Double = 0
    @Published var activeEnergy: Double = 0
    
   
// request to access data
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            print("HealthKit is not available")
            return
        }
        
        let typesToRead: Set<HKObjectType> = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        ]
        
        healthStore.requestAuthorization(toShare: [], read: typesToRead) { (success, error) in
            if success {
                self.updateAllData()
            } else if let error = error {
                print("Authorization failed with error: \(error.localizedDescription)")
            }
        }
    }
    //helper function to load all data
    func updateAllData(){
        updateStepCount()
        updateSleepHours()
        updateActiveEnergy()
        updateRunningDistance()
    }
    
    //step count
    func updateStepCount() {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error {
                print("Error reading steps: \(error.localizedDescription)")
                return
            }
            
            guard let result = result, let sum = result.sumQuantity() else {
                DispatchQueue.main.async {
                    self.stepCount = 0
                
                }
                return
            }
            //sum small units of steps
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            print("steps: \(steps)")
            DispatchQueue.main.async {
                // steps in cache
                let stepsLocalcurrent = UserDefaults.standard.integer(forKey: "stepsLocalcurrent")
                
                if stepsLocalcurrent != 0 {
                    self.stepCount = steps - stepsLocalcurrent
                
                }
                else{
                    self.stepCount = steps
                    

                }
            }
        }
        
        healthStore.execute(query)
    }
    
    
    func updateSleepHours() {
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            DispatchQueue.main.async { self.sleepHours = 0 }
            return
        }

        let calendar = Calendar.current
        let now = Date()
        let startOfPreviousNight = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: now.addingTimeInterval(-1 * 86400))!
        let endOfPreviousNight = now

        let predicate = HKQuery.predicateForSamples(withStart: startOfPreviousNight, end: endOfPreviousNight, options: .strictStartDate)
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                print("Error querying sleep samples: \(error.localizedDescription)")
                DispatchQueue.main.async { self.sleepHours = 0 }
                return
            }

            guard let samples = samples as? [HKCategorySample] else {
                DispatchQueue.main.async { self.sleepHours = 0 }
                return
            }


            var inBedSleepSeconds: TimeInterval = 0

            for sample in samples {
              
                if sample.value == HKCategoryValueSleepAnalysis.inBed.rawValue {
                    let duration = sample.endDate.timeIntervalSince(sample.startDate)
                    inBedSleepSeconds += duration
                }
            }
            //second to hours
            let inBedSleepHours = inBedSleepSeconds / 3600.0
            DispatchQueue.main.async {
                self.sleepHours = inBedSleepHours
            }
        }

        healthStore.execute(query)
    }


    func updateActiveEnergy() {
        let energyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: energyType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error {
                print("Error reading active energy: \(error.localizedDescription)")
                self.activeEnergy = 0
                return
            }
            
            guard let result = result, let sum = result.sumQuantity() else {
                print("No sum in result")
                DispatchQueue.main.async {
                    self.activeEnergy = 0
                }
                return
            }
            
            let energy = sum.doubleValue(for: HKUnit.kilocalorie())
            DispatchQueue.main.async {
                self.activeEnergy = energy
            }
        }
        
        healthStore.execute(query)
    }
    
    func updateRunningDistance() {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            guard let result = result, let sum = result.sumQuantity() else {
                DispatchQueue.main.async { self.runningDistance = 0 }
                return
            }
            
            let distance = sum.doubleValue(for: HKUnit.meter())
            DispatchQueue.main.async { self.runningDistance = distance / 1000 } // to kilometer
        }
        
        healthStore.execute(query)
    }
}
// debug view 
struct StepRead: View {
    @StateObject private var stepCountManager = StepCountManager()
    
    var body: some View {
        VStack {
            Text("Steps today: \(stepCountManager.stepCount)")
                .font(.title)
                .padding()
            Text("Sleep: \(String(format: "%.2f", stepCountManager.sleepHours))")
                .font(.title)
                .padding()
            Text("running: \(String(format: "%.2f", stepCountManager.runningDistance)) km")
                .font(.title)
                .padding()
           
        }
        .onAppear {
         
            stepCountManager.updateStepCount()
            stepCountManager.updateRunningDistance()
            stepCountManager.updateSleepHours()
            stepCountManager.updateActiveEnergy()
        }
    }
}

#Preview {
    StepRead()
}

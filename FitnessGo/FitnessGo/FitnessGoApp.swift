//
//  FitnessGoApp.swift
//  FitnessGo
//
//  Created by Michael on 30/8/2024.
//

import SwiftUI

@main
struct FitnessGoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var person = friendsRequest()
    @StateObject private var spinItemsModel = SpinItemsModel()
    @StateObject private var globalEnvironment = GlobalEnvironment()
    @StateObject private var checkboxModel = CheckboxModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(person)
                .environmentObject(spinItemsModel).environmentObject(globalEnvironment).environmentObject(checkboxModel)
        }
    }
}

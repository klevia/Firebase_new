//
//  Firebase_newApp.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 23.04.22.
//

import SwiftUI
import Firebase

@main
struct Firebase_newApp: App {

    init(){
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

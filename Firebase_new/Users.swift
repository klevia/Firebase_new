//
//  Users.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 30.04.22.
//

import Foundation

//created a struct that represents our habit categories
struct Users: Identifiable {
    
    var id : String
}

extension Date{
    
    func addDay(day: Int) -> Date{
        
        return Calendar.current.date(byAdding: .day, value: day, to: self) ?? Date()
        
    }
}

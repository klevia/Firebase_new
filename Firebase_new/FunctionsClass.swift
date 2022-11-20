//
//  FunctionsClass.swift
//  Button
//
//  Created by Klevia Ulqinaku on 10.11.22.
//
import Foundation
import SwiftUI

class FunctionsClass: ObservableObject {
    
    
    func arrangeArrays (elements: [Element], categories: [Categories]) -> [Categories]{
        var selectedOnes: [Categories] = []
        var result: [Categories] = []
        var dummy: [Categories] = categories
        print("Element two is : \(elements)")
        
        for element in elements{
            for category in categories {
                print("Element one is : \(element.id)")
                print("Category one is : \(category.id)")

                if (element.id == category.id){
                    selectedOnes.append(category)
                    if let index = dummy.firstIndex(where: {$0.id == category.id}){
                        dummy.remove(at: index)
                    }
                        
                }
            }
            
        }
        result.append(contentsOf: selectedOnes)
        result.append(contentsOf: dummy)
        print("Resulting array is: \(result)")
        return result
    }

}

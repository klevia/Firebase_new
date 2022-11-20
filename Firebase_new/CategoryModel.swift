//
//  CategoryModel.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 31.10.22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class CategoryModel : ObservableObject {
   @Published var mainCollection = [Categories]()
    
    
   /* func addData(categoryModel: Categories){
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        // let uploadObjectFetched: uploadObject = uploadObject(parameter1: colorObject)
        // Add a document to the collection
        do{
            try db.collection("Categories").document("Category 13").setData(from: categoryModel)
        } catch let error {
            print("shit")
        }
    }*/
    
    func getCategories() -> [Categories]{
        //get a reference to the database
        let db = Firestore.firestore()
        
        
        //read the documents at a specific path
        db.collection("Categories").getDocuments {snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.mainCollection = snapshot.documents.map { d in
                            
                            
                            
                            let result = d.data()
                            
                           
                            var habits : [Habit] = []
                            var colorObject: ColorObject = ColorObject(hue: 0.0, saturation: 0.0, brightness: 0.0)
                            var iconObject: IconObject = IconObject(name: "", link: "")
                            var lifeAreaObject: LifeAreaObject = LifeAreaObject(lifeAreaName: "", lifeAreaId: "")
                            
                            
                            if let habitData = result["habits"] as? [[String : Any]]{
                                
                                
                               
                              
                                
                                for index in habitData{
                                    
                                    if let try2 = index["lifeArea"] as? [String: Any] {
                                        lifeAreaObject = LifeAreaObject(lifeAreaName: try2["lifeAreaName"] as? String ?? "", lifeAreaId: try2["lifeAreaId"] as? String ?? "")
                                    }
                                    
                                    
                                    habits.append(Habit(
                                        id: UUID(), name: index["name"] as? String ?? "",
                                        deterioration: index["deterioration"] as? Double ?? 0.0,
                                        improvement: index["improvement"] as? Double ?? 0.0,
                                        lifeArea: lifeAreaObject, //LifeAreaObject(lifeAreaName: index["lifeArea"] as? String ?? "", lifeAreaId: index   ["lifeArea"] as? String ?? ""), //index["lifeArea"] as? String ?? "",
                                        times: index["times"] as? Int ?? 0,
                                        days: index["days"] as? Int ?? 0,
                                        selectedDays: index["selectedDays"] as? [Int] ?? [],
                                        reminderTime: index["reminderTime"] as? Timestamp ?? Timestamp()))
                                }
                            }
                            print("Habits are : \(habits)")
                            
                            

                            
                            if let idData = result["color"] as? [String: Any] {
                                colorObject = ColorObject(
                                    hue: idData["hue"] as? Double ?? 0.0,
                                    saturation: idData["saturation"] as? Double ?? 0.0,
                                    brightness: idData["brightness"] as? Double ?? 0.0
                                )
                            }
                            
                            if let iconData = result["icon"] as? [String: Any]{
                                iconObject = IconObject(
                                    name: iconData["name"] as? String ?? "",
                                    link: iconData["link"] as? String ?? "")
                            }

                            let name = d["name"] as? String ?? ""
                            let idCategory = d["id"] as? Int ?? 0
                            
                            
                            //print("Result is : \(Categories(id: UUID(), habits: habits, name: name, icon: iconObject, color: colorObject))")
                            self.mainCollection.append(Categories(id: idCategory, habits: habits, name: name, icon: iconObject, color: colorObject))
                            
                            return Categories(id: idCategory, habits: habits, name: name, icon: iconObject, color: colorObject)
                            
                        }
                    }
                    
                    
                }
                
            } else {
                //Handle Error
            }
        }
        return mainCollection
        
    }
    
    
    
    
    
    
}
struct Categories: Identifiable{
    var id : Int
    var habits: [Habit]
    var name: String
    var icon : IconObject
    var color : ColorObject
    
}

struct Habit : Identifiable{
    var id : UUID
    var name: String
    var deterioration: Double
    var improvement : Double
    var lifeArea : LifeAreaObject //to be changed to a lifeAreaObject
    var times: Int
    var days: Int
    var selectedDays: [Int]
    var reminderTime : Timestamp
}

struct IconObject : Codable {
    var name: String
    var link : String
}



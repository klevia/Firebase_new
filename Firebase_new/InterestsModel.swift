//
//  CategoryModel.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 19.11.22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class InterestsModel : ObservableObject {
   @Published var mainCollection = [Element]()
    
    

    func addData(name: String,interestsModel: Element){
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        // let uploadObjectFetched: uploadObject = uploadObject(parameter1: colorObject)
        // Add a document to the collection
        do{
            try db.collection("Interests").document(name).setData(from: interestsModel)
        } catch let error {
            print("shit")
        }
    }
    
    func getInterests() -> [Element]{
        //get a reference to the database
        let db = Firestore.firestore()
        
        
        //read the documents at a specific path
        db.collection("Interests").getDocuments {snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.mainCollection = snapshot.documents.map { d in
                            
                            let result = d.data()
                            var colorObject: ColorObject = ColorObject(hue: 0.0, saturation: 0.0, brightness: 0.0)
                            
                            if let idData = result["color"] as? [String: Any] {
                                colorObject = ColorObject(
                                    hue: idData["hue"] as? Double ?? 0.0,
                                    saturation: idData["saturation"] as? Double ?? 0.0,
                                    brightness: idData["brightness"] as? Double ?? 0.0
                                )
                            }
                            
                            let name = d["name"] as? String ?? ""
                            let idElement = d["id"] as? Int ?? 0
                            let selected = d["selected"] as? Bool ?? false
                            let link = d["link"] as? String ?? ""
                           
                            
                            
                            //print("Result is : \(Categories(id: UUID(), habits: habits, name: name, icon: iconObject, color: colorObject))")
                            self.mainCollection.append(Element(name: name, id: idElement, selected: selected, color: colorObject, link: link))
                            
                            return Element(name: name, id: idElement, selected: selected, color: colorObject, link: link)
                            
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

struct Element : Codable{
    var name: String
    var id: Int
    var selected: Bool
    var color : ColorObject
    var link : String
}

//
//  ViewModel.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 24.04.22.
//

import Foundation
import Firebase
import FirebaseStorage

class ViewModel: ObservableObject {
    @Published var list = [Habit_Categories]()
    
    
    func updateData(value: String,CategoriestoUpdate : Habit_Categories){
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to Update
        
        db.collection("LifeArea").document(CategoriestoUpdate.id).updateData([
            "question": FieldValue.arrayUnion([value]),
            "timestamp": FieldValue.arrayUnion([Timestamp()])
            
        ])
        
        
        /*setData(["name": "updated \(CategoriestoUpdate.name)"], merge: true) {error in
            // Check for errors
            if error == nil {
                // get the new data
                self.getData()
            }
            
        }*/
    }
    
    
    
    func deleteData(CategorytoDelete: Habit_Categories) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("LifeArea").document(CategorytoDelete.id).delete { error in
            if error == nil {
                
                
                DispatchQueue.main.async {
                    // No errors
                    self.list.removeAll { hc in
                        // Check for the habit category to remove
                        return hc.id == CategorytoDelete.id
                    }
                }
            }else{
                //error detected
            }
          
          
            
            
        }
    }
    
    func addData(name: String, urlString: String, question: Array<Any>){
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        // Add a document to the collection
        db.collection("LifeArea").addDocument(data: ["name":name , "url":urlString, "question":question]) { error in
            // check for error that occur while adding the data
            if error == nil{
                //No errors
                
                //Call get data to retrieve the latest data
                //self.getData()
            }else{
                //handle the error
            }
            
        }
    }
    
    
    
    
    
    //Create a fuction to fetch our data items and store it in this list above

    func getData(){
        //get a reference to the database
        let db = Firestore.firestore()
        
        
        //read the documents at a specific path
        
        db.collection("LifeArea").order(by: "name").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Habit_Categories(id: d.documentID,
                                                    name: d["name"] as? String ?? "",
                                                    url: d["url"] as? String ?? ""
                                                    , question: d["question"] as? Array ?? [],
                                                    timestamp: d["timestamp"] as? Array ?? [])
                        }
                    }
                    
                    
                }
            } else {
                //Handle Error
            }
        }
    }

        
        // Get the image data in storage for each image reference
        
        //Display the images
    }
    
    
    


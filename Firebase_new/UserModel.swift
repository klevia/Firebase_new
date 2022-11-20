//
//  ViewModel.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 30.04.22.
//

import Foundation
import Firebase
import FirebaseStorage
import SwiftUI
import SDWebImageSwiftUI
import grpc

class UserModel: ObservableObject {
    @Published var list = [Users]()
    @Published var list2 = [Habit_Categories]()
    @Published var list3 = [Questions]()
    @Published var documentId = ""

    
    
    
    //assign the main habit categories to all current users in the database
    // will be changed only to specific user after we will be able to get the user id upon download
    func updateData(u:Users){
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to Update
        db.collection("Users").document(u.id).collection("LifeArea").getDocuments { snapshot, error in
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list2 = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Habit_Categories(id: d.documentID,
                                                    name: d["name"] as? String ?? "",
                                                    url: d["url"] as? String ?? "",
                                                    question: d["question"] as? Array ?? [],
                                                    timestamp: d["timestamp"] as? Array ?? [])
                        }
                    }
                    
                    
                }
            } else {
                //Handle Error
            }
        }
    }
    
    //assign the main habit categories to all current users in the database
    // will be changed only to specific user after we will be able to get the user id upon download
   /* func updateQuestions(u:Users){
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to Update
        db.collection("Users").document(u.id).collection("Questions").getDocuments { snapshot, error in
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list3 = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Questions(id: d.documentID,
                                                    name: d["name"] as? String ?? "",
                                                    lifeArea: d["lifeArea"] as? Array ?? [])
                        }
                    }
                    
                    
                }
            } else {
                //Handle Error
            }
        }
    }*/
    
    func addLifeAreaToUser(id: String){
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Set the data to Update
        db.collection("Users").document(id).collection("LifeArea").getDocuments { snapshot, error in
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list2 = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Habit_Categories(id: d.documentID,
                                                    name: d["name"] as? String ?? "",
                                                    url: d["url"] as? String ?? "",
                                                    question: d["question"] as? Array ?? [],
                                                    timestamp: d["timestamp"] as? Array ?? [])
                        }
                    }
                    
                    
                }
            } else {
                //Handle Error
            }
        }
    }
    
    
    //adds a habit category as a subcollection to a selected user
    func addHabitCategory(UsertoUpdate : Users,id: String, name : String, url : String){
        let db = Firestore.firestore()
        
        let newDocRef = db.collection("Users").document(UsertoUpdate.id)
        
        newDocRef.collection("LifeArea").document().setData([
            "id" : id,
            "name" : name,
            "url" : url
        ])
    }
    
    //adds a Questions as a subcollection to a selected user
    func addQuestion(UsertoUpdate : Users,id: String, name : String,lifeArea : Array<Any>){
        let db = Firestore.firestore()
        
        let newDocRef = db.collection("Users").document(UsertoUpdate.id)
        
        newDocRef.collection("Questions").document().setData([
            "id" : id,
            "name" : name,
            "lifeArea" : lifeArea
        ])
    }
    
    //add a new habit category upon selecting an icon and typing the name
    func addNewHabitCategory(UsertoUpdate : String,id: String, name : String, url : String){
        let db = Firestore.firestore()
        
        let newDocRef = db.collection("Users").document(UsertoUpdate)
        
        newDocRef.collection("LifeArea").document().setData([
            "id" : id,
            "name" : name,
            "url" : url
        ])
    }
    
    
    func addAllLifeAreas(idofUser : String,id: String, name : String, url : String){
        let db = Firestore.firestore()
        
        let newDocRef = db.collection("Users").document(idofUser)
        
        newDocRef.collection("LifeArea").document().setData([
            "id" : id,
            "name" : name,
            "url" : url
        ])
    }
    func addOnlySelectedLifeAreas(idofUser : String){
        let db = Firestore.firestore()
        
        let newDocRef = db.collection("Users").document(idofUser)
        
        newDocRef.collection("LifeArea").whereField("name", isEqualTo: "Fitness").getDocuments { snapshot, error in
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list2 = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Habit_Categories(id: d.documentID,
                                                    name: d["name"] as? String ?? "",
                                                    url: d["url"] as? String ?? "",
                                                    question: d["question"] as? Array ?? [],
                                                    timestamp: d["timestamp"] as? Array ?? [])
                        }
                    }
                    
                    
                }
            } else {
                //Handle Error
            }
        }}
    
    func deleteData(CategorytoDelete: Users) {
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Specify the document to delete
        db.collection("Users").document(CategorytoDelete.id).delete { error in
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
    //delete for current user the habit category that corresponds to the given string as a name
    func deleteDocument(u: Users, d : String){
        let db = Firestore.firestore()
        
        
        db.collection("Users").document(u.id).collection("LifeArea").whereField("name", isEqualTo: d)
            .getDocuments(completion: { (snapshot, error ) in
                if let error = error {
                    
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        for document in snapshot!.documents {
                            db.collection("Users").document(u.id).collection("LifeArea").document("\(document.documentID)").delete()
                        }}
                }
                
            })
    }
    
    func deleteQuestion(u: Users, d : String){
        let db = Firestore.firestore()
        
        
        db.collection("Users").document(u.id).collection("Questions").whereField("name", isEqualTo: d)
            .getDocuments(completion: { (snapshot, error ) in
                if let error = error {
                    
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        for document in snapshot!.documents {
                            db.collection("Users").document(u.id).collection("Questions").document("\(document.documentID)").delete()
                        }}
                }
                
            })
    }
    
    //delete for current user the habit category that corresponds to the given string as a name
    func tryToAddDocument(u: Users, d : String, id:String,name:String, question: Array<Any>, timestamp:Array<Any>,url:String){
        let db = Firestore.firestore()
        
        
        db.collection("Users").document(u.id).collection("LifeArea").whereField("name", isEqualTo: d)
            .getDocuments(completion: { (snapshot, error ) in
                if let error = error {
                    
                    print(error)
                } else {
                    DispatchQueue.main.async {
                        for document in snapshot!.documents {
                            db.collection("Users").document(u.id).collection("LifeArea").document("\(document.documentID)").setData([
                                "id" : id,
                                "name" : name,
                                "question": question,
                                "timestamp": timestamp,
                                "url" : url
                            ])
                        }}
                }
                
            })
    }
    
    
    
    // adds a new user and assigns a unique id
    func addData(){
        
        // get a reference to the database
      
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        //uniqueId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        // Add a document to the collection
        //db.collection("Users").addDocument(data: ["id":  UIDevice.current.identifierForVendor?.uuidString ?? ""]) { error in
        ref = db.collection("Users").addDocument(data: ["id":  UIDevice.current.identifierForVendor?.uuidString ?? ""]) { [self] error in
            // check for error that occur while adding the data
            if error == nil{
                //No errors
                
                //Call get data to retrieve the latest data
                
                self.getData()
                print("Document added with ID: \(ref!.documentID)")
               // print("The unique generated id is : \(uniqueId)")
                documentId = ref?.documentID ?? "not working"
                print("\(documentId)")
                }else{
                //handle the error
            }
            
        }
        
    }
    
    func fsGetTasks(documentID: String) {
        
        //var list2 = [Habit_Categories]()
        let db = Firestore.firestore()
        
        db.collection("Users").document(documentID).collection("LifeArea").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.list2 = documents.map({ d in
                return Habit_Categories(id: d.documentID, name: d["name"] as? String ?? "",
                                        url: d["url"] as? String ?? "",
                                        question: d["question"] as? Array ?? [],
                                        timestamp: d["timestamp"] as? Array ?? [])
            })
        }
    }
    
    
    
    
    //Create a fuction to fetch our data items and store it in this list above
    func getData(){
        
        //get a reference to the database
        let db = Firestore.firestore()
        
        
        //read the documents at a specific path
        
        db.collection("Users").order(by: "id").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.list = snapshot.documents.map { d in
                            
                            //transform each document into a habit cat
                            return Users(id: d.documentID)
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





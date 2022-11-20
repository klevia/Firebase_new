//
//  Questions.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 29.08.22.
//

import Foundation

//created a struct that represents our habit categories
/*
 
 /*
  
  VStack{
      
      /*List (model.list) { item in
          
          HStack{
              
              AsyncImage(url: URL(string: item.url)){  image in
                  image.resizable()
                      .frame(width: 40, height: 35)
              } placeholder: {
                  ProgressView()
              }
              Text(item.name)
              Spacer()
              
              // Update Button
              
              
              Button(action: {
                  //model.updateData(CategoriestoUpdate: item)
                  
                  // the selected or pressed habit category is added to every user in the database
                  //for i in 0...users.list.count-1 {
                    //  users.addHabitCategory(UsertoUpdate: users.list[i], id: item.id, name: item.name, url: item.url)
                  //}
                  print(model.list)
                 
              }, label: {
                  Image(systemName: "pencil")
              })
                  .buttonStyle(BorderlessButtonStyle())
              
              //delete button
              Button(action: {
                  
                  // the selected or pressed habit category is deleted from every user in the database
                  for i in 0...users.list.count-1 {
                      users.deleteDocument(u:users.list[i] ,d: item.name)
                      }
                 // }
                  model.deleteData(CategorytoDelete: item)
                
                  
              }, label: {
                  Image(systemName: "minus.circle")
              })
              
          }//.onAppear(perform: loadImageFromFirebase)
      } */
          
  
      
      List (users.list) { user in
                      HStack{
                          Text(user.id)
                          Button(action: {
                       
                              for index in 0 ..< model.list.count{
                                  
                                 // if model.list[index].name == "Fitness"{
                                
                                      users.addHabitCategory(UsertoUpdate: user, id: model.list[index].id, name: model.list[index].name, url: model.list[index].url)
                                  //}
                              }
                              print(users.list)
                              //
                          }, label: {
                              Image(systemName: "pencil")
                          })
                              .buttonStyle(BorderlessButtonStyle())
                          
                          Button(action: {
                              
                         
                              //
                          }, label: {
                              Image(systemName: "plus")
                          })
                              .buttonStyle(BorderlessButtonStyle())
                          
                       
                      }
                  }
      
      Button(action: {
          
          //adds for current user the name that was typed and the selected icon
          //we can think about adding a unique id here as well
         // users.addNewHabitCategory(UsertoUpdate: users.documentId, id: UIDevice.current.identifierForVendor?.uuidString ?? "" ,name: name, url: clickedIcon ? selectedIcon : ",https://firebasestorage.googleapis.com:443/v0/b/test-firebase-2ad4d.appspot.com/o/images%2Ffitness.png?alt=media&token=9d8c81c8-b2e3-4d6f-b870-4eb87a52e3e7")
          print(model.list[0].id)
          
      }, label: {
          Image(systemName: "plus.circle")
      })
      
      Button(action: {
          //questions.getData()
          questions.filterForLifeAreas()
         
          
          
      }, label: {
          Text("Delete Documents")
      })
      
      Button(action: {
          //Call add data
          users.addData()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              for index in 0 ..< model.list.count{
                
                 // users.addAllLifeAreas(idofUser: users.documentId, id: model.list[index].id, name: model.list[index].name, url: model.list[index].url)
                 // users.tryToAddDocument(u: users.list[0], d: "Fitness", id: model.list[index].id, name: model.list[index].name, question: model.list[index].question, timestamp: model.list[index].timestamp, url: model.list[index].url)
              }
          }
         
          
          
          
      }, label: {
          Text("Add new User")
      })
      
      Button(action: {
          //Call add data
          //print("The new users id is : \(users.documentId)")
          //print("The print is :\(Firestore.firestore().collection("LifeArea"))")
          //print(users.list[0])
         // print(users.list2)
          //users.addOnlySelectedLifeAreas(idofUser: users.list[0].id)
          //print(users.list2)
          //print(questions.mainCollection[0].lifeArea.contains("Fitness"))
          //print(users.list3)
          
          
          print("All question are : \(questions.surveyArray.map({$0.question}))")
          
          
      }, label: {
          Text("Show id")
      })
      // If you have 3 or more arrays to sort together, you can sort one of the arrays along with its offsets, use map to extract the offsets, and then use map to order the other arrays:
      
      let offsets = retrievedStrings.enumerated().sorted { $0.element < $1.element }.map { $0.offset }
      
      let sortedImages = offsets.map { retrievedImages[$0]}
      let sortedUrls = offsets.map { retrievedUrls[$0]}
      
      Button(action: {
          //Call add data
          //retrieveIcons()
        //  print(sortedUrls)
        //  print(sortedImages)
          for index in 0 ..< users.list.count{
          users.updateData(u: users.list[index])
          }
          
          print("USER LIST 2 \(users.list2)")
          print("USER LIST 3 \(users.list3)")
      }, label: {
          Text("Display icons")
      })
      
      Divider()
      
      VStack(spacing: 5) {
          TextField("Name", text: $name)
              .textFieldStyle(RoundedBorderTextFieldStyle())
          
          
          
          HStack{
              ForEach(sortedImages.indices, id: \.self) {i in
                  Image(uiImage: sortedImages[i])
                      .resizable()
                      .frame(width: 30, height: 30)
                      .onTapGesture {
                          selectedIcon = sortedUrls[i].absoluteString
                          clickedIcon = true
                      }
              }
          }
          .onAppear {
              retrieveIcons()
              // retrieveUrls()
          }
          Button(action: {
              //Call add data
              model.addData(name: name, urlString: clickedIcon ? selectedIcon : "https://firebasestorage.googleapis.com:443/v0/b/test-firebase-2ad4d.appspot.com/o/images%2Ffitness.png?alt=media&token=9d8c81c8-b2e3-4d6f-b870-4eb87a52e3e7", question: [0])
              
              // Clear the text fields
              name = ""
              clickedIcon = false
          }, label: {
              Text("Add Habit Category")
          })
          
          VStack(spacing: 5) {
              TextField("Value", text: $value)
                  .textFieldStyle(RoundedBorderTextFieldStyle())
          }
          
          Button(action: {
              //Call add data
              model.updateData(value: value,CategoriestoUpdate: model.list[0])
              
              // Clear the text fields
              value = ""
              clickedIcon = false
          }, label: {
              Text("Add Entry")
          })
          
          
      }
      .padding()
      
  }
  */
 func retrieveIcons(){
     
     // Get the data from the database
     let db = Firestore.firestore()
     db.collection("Icons").order(by: "number").getDocuments { snapshot, error in
         if error == nil && snapshot != nil {
             
             var paths = [String]()
             //loop through all returned docs
             for doc in snapshot!.documents {
                 //extract path and add to array
                 paths.append(doc["url"] as! String)
             }
             // Loop through each file path and fetch the data from storage
             let sortedPaths = paths.sorted (by: >)
             
             
             for path in sortedPaths {
                 
                 // Get a reference to storage
                 let storageRef = Storage.storage().reference()
                 
                 //Specify path
                 let fileRef =  storageRef.child(path)
                 
                 
                 //Retrieve the data
                 fileRef.downloadURL {  url, error in
                     
                     
                     // Check for errors
                     if error == nil  && url != nil{
                         
                         // Create Uiimage and put it into our array for display
                         if let urlString =  URL(string: url?.absoluteString ?? ""){
                             
                             fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                                 // Check for errors
                                 if error == nil  && data != nil{
                                     
                                     // Create Uiimage and put it into our array for display
                                     if let image = UIImage(data: data!){
                                         
                                         DispatchQueue.main.async {
                                             retrievedImages.append(image)
                                             retrievedUrls.append(urlString)
                                             retrievedStrings.append(urlString.absoluteString)
                                             
                                             
                                         }
                                         
                                     }
                                     
                                 }
                             }
                             
                         }
                         
                     }
                     
                     
                 }
                 
             }}}
     
     
 }
 
 // Get the image data in storage for each image reference
 
 //Display the images
 
 
 /*func retrieveUrls(){
  
  // Get the data from the database
  let db = Firestore.firestore()
  db.collection("Icons").getDocuments { snapshot, error in
  if error == nil && snapshot != nil {
  
  var paths = [String]()
  //loop through all returned docs
  for doc in snapshot!.documents {
  //extract path and add to array
  paths.append(doc["url"] as! String)
  }
  // Loop through each file path and fetch the data from storage
  
  for path in paths {
  
  // Get a reference to storage
  let storageRef = Storage.storage().reference()
  
  //Specify path
  let fileRef = storageRef.child(path)
  
  //Retrieve the data
  fileRef.downloadURL { url, error in
  // Check for errors
  if error == nil  && url != nil{
  
  // Create Uiimage and put it into our array for display
  if let urlString = URL(string: url?.absoluteString ?? ""){
  
  DispatchQueue.main.async {
  retrievedUrls.append(urlString)
  }
  }
  }
  }
  
  }
  
  }}}*/
 
 
 // Get the image data in storage for each image reference
 
 //Display the images
 
 func featchImageUrl(name : String) {
     let storage = Storage.storage()
     let pathReference = storage.reference(withPath: "images/\(name)/.png")
     pathReference.downloadURL { url, error in
         if let error = error {
             // Handle any errors
             print(error)
         } else {
             guard let urlString = url?.absoluteString else {
                 return
             }
             self.url = urlString
         }
     }
 }
 func addHabitCategory(UsertoUpdate : Users){
     let db = Firestore.firestore()
     let newDocRef = db.collection("Users").document(UsertoUpdate.id)
     
     newDocRef.collection("LifeArea").document().setData([
         "name" : "fitness",
         "url" : "https://firebasestorage.googleapis.com/v0/b/test-firebase-2ad4d.appspot//.com/o/images%2Fsun.max%402x.png?alt=media&token=7bac4b0f-c399-42b6-8c4f-7f4fe7175cd6"
     ])
 }
 
 func loadImageFromFirebase() {
     let storage = Storage.storage().reference(withPath: "images/fitness.png")
     storage.downloadURL { (url, error) in
         if error != nil {
             print((error?.localizedDescription)!)
             return
         }
         
         self.imageURL = url!
     }
 }
}

 
 */

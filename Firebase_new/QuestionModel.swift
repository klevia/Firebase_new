//
//  QuestionModel.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 29.08.22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

class QuestionModel: ObservableObject {
    
    @Published var mainLifeAreas = [LifeArea]()
   
    
    //Create a fuction to fetch our data items and store it in this list above
    func getData() -> [Questions]{
        
        //get a reference to the database
        let db = Firestore.firestore()
        var mainCollection = [Questions]()
        
        //read the documents at a specific path
        
        db.collection("Questions").getDocuments { snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        mainCollection = snapshot.documents.map { d in
                            
                            
                            
                            let result = d.data()
                            var colorObject: ColorObject = ColorObject(hue: 0.0, saturation: 0.0, brightness: 0.0)
                            var lifeAreaObjects : [LifeAreaObject] = []
                            var questionObject: QuestionObject = QuestionObject(questionName: "", questionId: "")
                            
                            if let idData = result["ColorObject"] as? [String: Any] {
                                colorObject = ColorObject(
                                    hue: idData["hue"] as? Double ?? 0.0,
                                    saturation: idData["saturation"] as? Double ?? 0.0,
                                    brightness: idData["brightness"] as? Double ?? 0.0
                                )
                            }
                            
                            if let lifeAreaData = result["lifeAreaObjects"] as? [[String : Any]]{
                                for index in lifeAreaData{
                                    lifeAreaObjects.append(LifeAreaObject(
                                        lifeAreaName: index["lifeAreaName"] as? String ?? "",
                                        lifeAreaId: index["lifeAreaId"] as? String ?? ""
                                    ) )
                                }
                            }
                            
                            if let questionDate = result["QuestionObject"] as? [String: Any] {
                                questionObject = QuestionObject(
                                    questionName: questionDate["questionName"] as? String ?? "",
                                    questionId: questionDate["questionId"] as? String ?? ""
                                )
                            }
                            
                            
                            
                            
                            return Questions(questionObject: questionObject,
                                             lifeAreaObjects: lifeAreaObjects,
                                             color: colorObject)
                        }
                    }
                    
                    
                }
                
            } else {
                //Handle Error
            }
        }
        return mainCollection
        
    }
    
    func addData(questionModel: Questions){
        
        // get a reference to the database
        let db = Firestore.firestore()
        
        // let uploadObjectFetched: uploadObject = uploadObject(parameter1: colorObject)
        // Add a document to the collection
        do{
            try db.collection("Questions").document("Question4").setData(from: questionModel)
        } catch let error {
            print("shit")
        }
        
        
    }
    
    
    
    func addFakeData(fakeData: String){
        let db = Firestore.firestore()
        db.collection("Questions").addDocument(data: ["fakeData": fakeData]) { error in
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
    
    
    
    func filterForLifeAreas(questions: [Questions]) -> [SurveyElement]{
        
        
       var surveyArray = [SurveyElement]()
        
        for mainCollectionElement in questions{
            
            let commonLifeAreas = mainCollectionElement.lifeAreaObjects.map({$0.lifeAreaName}).filter{fakeData.map({$0.lifeAreaName}).contains($0)}
            
            if !commonLifeAreas.isEmpty{
                surveyArray.append(SurveyElement(
                    questionObject: mainCollectionElement.questionObject,
                    lifeAreaObjects: mainCollectionElement.lifeAreaObjects,
                    colorObject: mainCollectionElement.color,
                    rating: 0.6))
            }
        }
        return surveyArray
    }
    
   /* func journalEntryFunctionAutomated(){
        
        let startDate = Date().addDay(day: -3)
        let endDate = Date()
        for index in surveyArray.indices{
            
            surveyArray[index].rating = Double.random(in: 0.1...1)
        }
        
        let wellBeingMeasurmentEntry: WellBeingMeasurment = WellBeingMeasurment(startDate: startDate, endDate: endDate, surveyArray: surveyArray)
        print(wellBeingMeasurmentEntry)
    }*/
}

//   for index in 0 ..< fakeData.count{

//fakeData.map({$0.lifeArea}))

//  if  questions.mainCollection[i].lifeArea.contains(fakeData[index].lifeArea){
/*  if  !temp.contains(questions.mainCollection[i].id) {/*
                                                         
                                                         
                                                         
                                                         users.addQuestion(UsertoUpdate: user, id: questions.mainCollection[i].id, name: questions.mainCollection[i].name, lifeArea: questions.mainCollection[i].lifeArea)
                                                         users.updateQuestions(u: user)
                                                         temp += [questions.mainCollection[i].id]
                                                         }
                                                         
                                                         //}
                                                         //}
                                                         }
                                                         
                                                         
                                                         
                                                         
                                                         }
                                                         
                                                         
                                                         
                                                         }*/ */


struct LifeArea: Codable, Hashable{
    var id = UUID()
    var lifeAreaId : String
    var lifeAreaName: String
}

let fakeData : [LifeArea] = [LifeArea(lifeAreaId: "1", lifeAreaName: "Fitness"),
                             LifeArea(lifeAreaId: "4", lifeAreaName: "Focus")
]

struct Questions: Codable {
    var questionObject: QuestionObject
    var lifeAreaObjects : [LifeAreaObject]
    var color: ColorObject
}

struct uploadObject: Codable{
    var parameter1: Questions
}
struct ColorObject : Codable {
    var hue: Double
    var saturation : Double
    var brightness : Double
}
struct LifeAreaObject : Codable{
    var lifeAreaName : String
    var lifeAreaId: String
}
struct QuestionObject: Codable{
    var questionName: String
    var questionId: String
}

struct SurveyElement: Codable{
    
    var questionObject : QuestionObject
    var lifeAreaObjects : [LifeAreaObject]
    var colorObject : ColorObject
    var rating: Double
    
}






















































/*func deleteData(CategorytoDelete: Questions) {
 // Get a reference to the database
 let db = Firestore.firestore()
 
 // Specify the document to delete
 db.collection("Questions").document(CategorytoDelete.id).delete { error in
 if error == nil {
 
 
 DispatchQueue.main.async {
 // No errors
 self.mainCollection.removeAll { hc in
 // Check for the habit category to remove
 return hc.id == CategorytoDelete.id
 }
 }
 }else{
 //error detected
 }
 
 
 
 
 }
 }*/


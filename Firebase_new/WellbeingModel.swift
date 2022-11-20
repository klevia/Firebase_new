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

class WellbeingModel: ObservableObject {
    @Published var mainCollection = [WellBeingMeasurment]()
    @Published var measurements = [Measurements]()
    
    func getData(){
        let db = Firestore.firestore()
        db.collection("Users").document("6K11SvSBabn81Z4qvQaW").collection("WellbeingMeasurements").getDocuments{ snapshot, error in
            //check for errors
            if error == nil {
                //no errors
                if let snapshot = snapshot {
                    
                    //update the list property in the main thread since it causes ui changes
                    DispatchQueue.main.async {
                        // get all documents and create instances of the habit category struct
                        self.measurements = snapshot.documents.map { d in
                            
                            let result = d.data()
                            var ratings : [Double] = []
                            let retrievedStartDate = result["startDate"] as! Timestamp
                            let retrievedEndDate = result["endDate"] as! Timestamp
                            
                            let startDate = Date(timeIntervalSince1970: TimeInterval(retrievedStartDate.seconds))
                            let endDate = Date(timeIntervalSince1970: TimeInterval(retrievedEndDate.seconds))
                            
                            if let surveyArray = result["surveyArray"] as? [[String : Any]]{
                                for index in surveyArray{
                                    ratings.append(index["rating"] as? Double ?? 0.0)
                                }
                            }
                            let averageRating = ratings.reduce(0.0,+) / Double(ratings.count)
                            
                            return Measurements(startDate: startDate, endDate: endDate, averageRating: averageRating)
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    //adds a WellbeingModel as a subcollection to a selected user
    func addWellbeing(userToUpdate: String, wellBeingMeasurement : WellBeingMeasurment){
        
        let db = Firestore.firestore()
        let userReference = db.collection("Users").document(userToUpdate)
        do{
            try userReference.collection("WellbeingMeasurements").document("WellbeingMeasure2").setData(from: wellBeingMeasurement)
        } catch let error{}
    }
    
    
    
    
    
}

struct WellBeingMeasurment: Codable{
    
    var startDate: Date
    var endDate: Date
    var surveyArray: [SurveyElement]
    
}
struct Measurements : Codable{
    var startDate : Date
    var endDate: Date
    var averageRating: Double
}























































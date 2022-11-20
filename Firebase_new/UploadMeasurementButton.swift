//
//  UploadMeasurementButton.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 15.10.22.
//

import SwiftUI

struct UploadMeasurementButton: View {
    
    @EnvironmentObject var wellBeing: WellbeingModel
    
    var body: some View {
        
        let surveryElement1 = SurveyElement(
            questionObject: QuestionObject(questionName: "How's your mood", questionId: UUID().uuidString),
            lifeAreaObjects: [
                LifeAreaObject(lifeAreaName: "Fitness", lifeAreaId: UUID().uuidString),
                LifeAreaObject(lifeAreaName: "Focus", lifeAreaId: UUID().uuidString)
            ],
            colorObject: ColorObject(hue: 0.76, saturation: 1.0, brightness: 1.0),
            rating: 0.76
        )
        
        let surveyElement2 = SurveyElement(
            questionObject: QuestionObject(questionName: "How's your energy", questionId: UUID().uuidString),
            lifeAreaObjects: [
                LifeAreaObject(lifeAreaName: "Fitness", lifeAreaId: UUID().uuidString),
                LifeAreaObject(lifeAreaName: "Career", lifeAreaId: UUID().uuidString)
            ],
            colorObject: ColorObject(hue: 0.56, saturation: 1.0, brightness: 1.0),
            rating: 0.26
        )
        let surveyElement3 = SurveyElement(
            questionObject: QuestionObject(questionName: "How's your concentration", questionId: UUID().uuidString),
            lifeAreaObjects: [
                LifeAreaObject(lifeAreaName: "Diet", lifeAreaId: UUID().uuidString),
                LifeAreaObject(lifeAreaName: "Fitness", lifeAreaId: UUID().uuidString)
            ],
            colorObject: ColorObject(hue: 0.56, saturation: 1.0, brightness: 1.0),
            rating: 0.5
        )
        
        let wellBeingMeasurement: WellBeingMeasurment = WellBeingMeasurment(
            startDate: Date().addDay(day: -4),
            endDate: Date().addDay(day: -1),
            surveyArray: [surveryElement1, surveyElement2])
        
        let wellBeingMeasurement2: WellBeingMeasurment = WellBeingMeasurment(
            startDate: Date().addDay(day: -2),
            endDate: Date().addDay(day: -1),
            surveyArray: [surveryElement1, surveyElement2,surveyElement3])
        
        Button(action:{
           
            //wellBeing.addWellbeing(userToUpdate: "6K11SvSBabn81Z4qvQaW", wellBeingMeasurement: wellBeingMeasurement2)
            wellBeing.getData()
            print(wellBeing.measurements)
            
        }){
            Text("Upload WellBeing Measurment")
                .foregroundColor(Color.white)
                .padding()
                .background(Color.green.opacity(0.8))
                .cornerRadius(20)
        }
        
        
    }
}


struct UploadMeasurementButton_Previews: PreviewProvider {
    static var previews: some View {
        UploadMeasurementButton()
    }
}

//
//  ContentView.swift
//  Firebase_new
//
//  Created by Klevia Ulqinaku on 23.04.22.
//

import SwiftUI
import Firebase
import FirebaseStorage
import SDWebImageSwiftUI



struct ContentView: View {
    @ObservedObject var categories = CategoryModel()
    @ObservedObject var interests = InterestsModel()
    @State private var showArray = false
    @State private var showInterests = false
    @State var categoriess = [Categories]()
    @State var usersInterests = [Element]()
    @State var finalArray : [Categories] = []
    
    
    init(){
        categoriess = categories.getCategories()
        usersInterests = interests.getInterests()
        
    }
    
    var body: some View {
        if !showInterests{
            InterestView(showInterests: $showInterests, usersInterests: $usersInterests, categoriess: $categoriess)
        }else if !showArray {
                ButtonView(categoriess: $categoriess, finalArray: $finalArray, usersInterests: $usersInterests, showArray: $showArray)
                
            } else {
                CategoriesView(finalArray: $finalArray)
            }
        }
    
}


    

    
    struct CategoriesView: View{
        @Binding var finalArray : [Categories]
        @State var showingHabitHub = false
        
        var body: some View {
            
            ZStack{
                Color.black
                    .ignoresSafeArea()
                VStack(spacing: 16){
                    
                    Text("HabitHub")
                        .foregroundColor(.white)
                        .font(.custom("Montserrat-Regular", size: 24).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading,24)
                    
                    ScrollView(.vertical,showsIndicators: false){
                        VStack(spacing: 16){
                            ForEach(finalArray,id: \.id){ category in
                                
                                
                                VStack{
                                    Text(category.name)
                                        .foregroundColor(Color(hue: category.color.hue, saturation: category.color.saturation, brightness: category.color.saturation))
                                        .lineLimit(1)
                                        .font(.custom("Montserrat-Regular", size: 20).bold())
                                        .frame(maxWidth:.infinity, alignment: .topLeading)
                                        .padding(.leading,24)
                                    
                                    ZStack{
                                        AsyncImage(url: URL(string: category.icon.link)){  image1 in
                                            
                                            image1
                                                .resizable()
                                                .renderingMode(.template)
                                                .aspectRatio(contentMode: .fit)
                                                .foregroundColor(Color(hue: category.color.hue, saturation: 0.2 ,brightness: 1).opacity(0.5))
                                                .frame(width: 125, height: 115)
                                                .padding(.leading,16)
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                        }
                                    placeholder: {
                                        ProgressView()
                                            .frame(width: 90, height: 90)
                                            .padding(.bottom, 24)
                                    }
                                        ScrollView(.horizontal,showsIndicators: false){
                                            VStack(alignment: .leading,spacing: 16){
                                                LazyHStack(spacing: 8){
                                                    ForEach(category.habits.dropLast(category.habits.count/2)){ habit in
                                                        Text(habit.name)
                                                            .foregroundColor(Color.white)
                                                            .padding()
                                                            .background(Color(hue: category.color.hue, saturation: 0.2 ,brightness: 1).opacity(0.2))
                                                            .clipShape(Capsule())
                                                        
                                                    }
                                                    
                                                }
                                                LazyHStack(spacing: 8){
                                                    ForEach(category.habits.dropFirst((category.habits.count/2) + (category.habits.count % 2))){ habit in
                                                        Text(habit.name)
                                                            .foregroundColor(Color.white)
                                                            .padding()
                                                        // .background(Color(hue: category.color.hue, saturation: 0.2 ,brightness: 1).opacity(0.2), in: Capsule())
                                                            .background(Color(hue: category.color.hue, saturation: 0.2 ,brightness: 1).opacity(0.2))
                                                            .clipShape(Capsule())
                                                        
                                                    }
                                                    
                                                }
                                            }
                                            .padding(.leading,16)
                                        }                 }
                                    
                                }
                                .frame(maxWidth:.infinity)
                                .cornerRadius(30)
                            }
                        }.frame(maxWidth: .infinity)
                        
                    }
                    /*if !showingHabitHub{
                        VStack(spacing: 16){
                            Button(action:{
                                //categoriess = categories.getCategories()
                                
                                
                                showingHabitHub = true
                                
                                
                                //categories.addData(categoryModel: Categories(habits: [Habit(id: UUID(), name: "Limit sugar", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp())], name: "Dedicated to my Diet", icon: IconObject(name: "", link: ""), color: ColorObject(hue: 0.1, saturation: 0.2, brightness: 0.6)))
                               // print(categoriess)
                                
                                
                            }){
                                
                                Text("Fetch Questions and Filter")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .background(Color.blue.opacity(0.8))
                                    .cornerRadius(20)
                            }
                            Button(action:{
                               /* categories.addData(categoryModel:
                                Categories(id: UUID(),
                                habits: [Habit(id: UUID(), name: "Go to bed before 11 pm", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Intermittent fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Do a morning exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Spend time in the sun", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Eat dinner 3 hours before sleeping", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "No caffeine after midday", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Avoid using electronics in bed", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Dim lights after sunset", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Use a blue light filter after sunset", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                ],
                                name: "Circadian Rhythm",
                                icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMental%20Health%204.png?alt=media&token=3f62fd00-79f7-400e-9c2b-40181290fe9c"),
                                color: ColorObject(hue: 0.41654, saturation: 1, brightness: 1)))
                                
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Call a friend", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Gratitude journal", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Spend time with your pet", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Hang out with a friend", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Do a kind gesture towards a loved one", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Listen with intent", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Call a family member", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Go on a date", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Relationship",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FRelationships.png?alt=media&token=07a6baa6-92e3-423c-b293-49bc44d2afb9"),
                                 color: ColorObject(hue: 0.951654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Make the bed", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Plan your day", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Make a to-do list", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Tidy your workspace", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Deep clean the house", deterioration: 1, improvement: -1, lifeArea: "organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Plan your day", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Intermittent Fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meditation", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Yoga", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Organization",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FDeep%20Work.png?alt=media&token=84b9a120-5db9-4a42-a580-37938ffd7d5c"),
                                 color: ColorObject(hue: 0.951654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "No social media", deterioration: 1, improvement: -1, lifeArea: "Focus", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Put devices on Dnd", deterioration: 1, improvement: -1, lifeArea: "Focus", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Use a pomodoro technique", deterioration: 1, improvement: -1, lifeArea: "Productivity", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Organize your workspace", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Plan your day", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Intermittent Fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meditation", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Yoga", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Stay focued/deep work",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FDeep%20Work.png?alt=media&token=84b9a120-5db9-4a42-a580-37938ffd7d5c"),
                                 color: ColorObject(hue: 0.951654, saturation: 1, brightness: 1)))
                                 
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Change your pillow covers", deterioration: 1, improvement: -1, lifeArea: "Selfcare", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Clean your makeup brushes", deterioration: 1, improvement: -1, lifeArea: "Selfcare", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Eat fruits", deterioration: 1, improvement: -1, lifeArea: "Diet", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Limit sugar", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No fried food", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Wear less make up", deterioration: 1, improvement: -1, lifeArea: "Selfcare", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Wear sunscreen", deterioration: 1, improvement: -1, lifeArea: "Selfcare", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Make a face mask", deterioration: 1, improvement: -1, lifeArea: "Selfcare", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Skin-care",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMental%20Health%201.png?alt=media&token=a93476cd-7ff2-4f49-a249-6f4b946b17fa"),
                                 color: ColorObject(hue: 0.851654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Make a grocery list", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meal Prepping", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Make coffee at home", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Make a budget", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Clean your car at home", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Eat home cooked food", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Stop smoking", deterioration: 1, improvement: -1, lifeArea: "Focus", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No online shooping", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Switch off the lights", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Track your spending", deterioration: 1, improvement: -1, lifeArea: "Finance", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Finance",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FPiggy%20Bank.png?alt=media&token=4fef128a-7823-4d52-9ea9-5a54eafa18c4"),
                                 color: ColorObject(hue: 0.651654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Read a book", deterioration: 1, improvement: -1, lifeArea: "Knowledge", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Solve a sudoku puzzle", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Listen to a podcast", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Play chess", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Practice a new language", deterioration: 1, improvement: -1, lifeArea: "Knowledge", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Mentally Stimulated",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMental%20Health%204.png?alt=media&token=3f62fd00-79f7-400e-9c2b-40181290fe9c"),
                                 color: ColorObject(hue: 0.41654, saturation: 1, brightness: 1)))
                                 
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Go to bed before 11 pm", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Intermittent fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Do a morning exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Spend time in the sun", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Eat dinner 3 hours before sleeping", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No caffeine after midday", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Avoid using electronics in bed", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Dim lights after sunset", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Use a blue light filter after sunset", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())
                                 ],
                                 name: "Circadian Rhythm",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMental%20Health%204.png?alt=media&token=3f62fd00-79f7-400e-9c2b-40181290fe9c"),
                                 color: ColorObject(hue: 0.41654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Read a book", deterioration: 1, improvement: -1, lifeArea: "Knowledge", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Solve a sudoku puzzle", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Listen to a podcast", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Play chess", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Practice a new language", deterioration: 1, improvement: -1, lifeArea: "Knowledge", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Mentally Stimulated",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMental%20Health%204.png?alt=media&token=3f62fd00-79f7-400e-9c2b-40181290fe9c"),
                                 color: ColorObject(hue: 0.41654, saturation: 1, brightness: 1)))
                                 
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Plan the next day", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No mid/day carbs", deterioration: 1, improvement: -1, lifeArea: "Diet", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Limit sugar", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Spend time outdoors in the day", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Intermittent fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No social media", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Use pomodoro technique", deterioration: 1, improvement: -1, lifeArea: "Productivity", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No smoking", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Yoga", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meditation", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Organize your workspace", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No alcohol", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Brain booster",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMoon%20blanket%20-%20Sleep.png?alt=media&token=cc3dba93-0e27-459f-8f93-0a050c803355"),
                                 color: ColorObject(hue: 0.21654, saturation: 1, brightness: 1)))
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Limit sugar", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Have a light lunch", deterioration: 1, improvement: -1, lifeArea: "Diet", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No caffeine for the first 90 mins of the day", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Spend time outdoors in the day", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Intermittent fasting", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Take a nap", deterioration: 1, improvement: -1, lifeArea: "Productivity", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Energizing your day",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMoon%20blanket%20-%20Sleep.png?alt=media&token=cc3dba93-0e27-459f-8f93-0a050c803355"),
                                 color: ColorObject(hue: 0.95654, saturation: 1, brightness: 1)))
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Make a to-do list", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Accomplishment Journal", deterioration: 1, improvement: -1, lifeArea: "Productivity", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Plan the next day", deterioration: 1, improvement: -1, lifeArea: "Organization", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Limit sugar", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No fast food", deterioration: 1, improvement: -1, lifeArea: "Diet", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No alcohol", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Caffeine intake", deterioration: 1, improvement: -1, lifeArea: "Productivity", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Vitamin B3 and zinc", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Boost your motivation",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMoon%20blanket%20-%20Sleep.png?alt=media&token=cc3dba93-0e27-459f-8f93-0a050c803355"),
                                 color: ColorObject(hue: 0.75654, saturation: 1, brightness: 1)))
                                 
                                 
                                 
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Have a warm shower", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink chamomille tea", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Avoid using electronics in bed", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Lower the room temperature", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Dim lights after sunset", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Use a blue light filter after sunset", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Eat dinner 3 hrs before bedtime", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No caffeine after noon", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meditate", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Slee..zZz well",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FMoon%20blanket%20-%20Sleep.png?alt=media&token=cc3dba93-0e27-459f-8f93-0a050c803355"),
                                 color: ColorObject(hue: 0.35654, saturation: 1, brightness: 1)))
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Yoga", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Walk", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Morning Strech", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Lift weights", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Running", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Go swimming", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Ride a bike", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Pilates", deterioration: 1, improvement: -1, lifeArea: "Mental Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Zumba", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Crossfit", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Football", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Basketball", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Tennis", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Badminton", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Boxing", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Cricket", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Get active",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FDumbells.png?alt=media&token=cd520811-53f0-4624-8ab0-454b8a72c3a0"),
                                 color: ColorObject(hue: 0.654, saturation: 1, brightness: 1)))
                                 categories.addData(categoryModel:
                                 Categories(id: UUID(),
                                 habits: [Habit(id: UUID(), name: "7-9 hours of sleep", deterioration: 1, improvement: -1, lifeArea: "Sleep", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Chat with a friend", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Drink water", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Chat with a friend", deterioration: 1, improvement: -1, lifeArea: "Relationship", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Spend time outdoors", deterioration: 1, improvement: -1, lifeArea: "Circadian Rhythm", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Cold shower", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Exercise", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Yoga", deterioration: 1, improvement: -1, lifeArea: "Fitness", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Meditation", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Gratitude Journal", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Disconnect and unplug", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Limit caffeine intake", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No phone walks", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No sugar drinks", deterioration: 1, improvement: -1, lifeArea: "Diet", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Practice a hoby", deterioration: 1, improvement: -1, lifeArea: "Mental Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "Read a book", deterioration: 1, improvement: -1, lifeArea: "Knowledge", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp()),
                                 Habit(id: UUID(), name: "No drugs/alcohol", deterioration: 1, improvement: -1, lifeArea: "Health", times: 1, days: 1, selectedDays: [1,3,5], reminderTime: Timestamp())],
                                 name: "Calm and relaxed",
                                 icon: IconObject(name: "", link: "https://firebasestorage.googleapis.com/v0/b/categoryapp-dff92.appspot.com/o/images%2FCircadian%20Rhythm.png?alt=media&token=cce5d715-3eab-4601-b66e-7c0d1f7ba7a2"),
                                 color: ColorObject(hue: 0.4, saturation: 1, brightness: 1)))*/
                                //categories.addData(categoryModel: Categories(id: UUID(), habits: [Habit(id: UUID(), name: "Intermittent fasting", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Limit sugar", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "No fast food", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Intermittent fasting", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Meal Prepping", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp())], name: "Dedicated to my Diet", icon: IconObject(name: "", link: ""), color: ColorObject(hue: 0.1, saturation: 0.2, brightness: 0.6)))
                                
                                // categories.addData(categoryModel: Categories(id: UUID(), habits: [Habit(id: UUID(), name: "Schedule your day", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Pomodoro Technique", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Use a todo list", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Accomplishment Journal", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp()), Habit(id: UUID(), name: "Silence Social Media", deterioration: -1.0, improvement: 1.0, lifeArea: "Diet", times: 5, days: 7, selectedDays: [1,3,5], reminderTime: Timestamp())], name: "Get sh*t done", icon: IconObject(name: "", link: ""), color: ColorObject(hue: 0.1, saturation: 0.2, brightness: 0.6)))
                                
                                
                                
                            }){
                                
                                Text("Upload Category")
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .background(Color.orange.opacity(0.8))
                                    .cornerRadius(20)
                            }
                            //UploadMeasurementButton()
                        }}*/
                }
            }
            //.environmentObject(wellBeing)
            
        }
    }
struct ButtonView: View {
    @Binding var categoriess : [Categories]
    @ObservedObject var categories = CategoryModel()
    @Binding var finalArray : [Categories]
    @Binding var usersInterests : [Element]
    @State var newElements : [Element] = []
    @State var didTap: Bool = false
    @ObservedObject var functions = FunctionsClass()
    @Binding var showArray : Bool

    
    var body: some View {
        ZStack{
            ScrollView(.vertical,showsIndicators: false){
                VStack(spacing: 12){
                    ForEach(usersInterests.indices){ index in
                                    Button(action: {
                                        if(usersInterests[index].selected == false){
                                            usersInterests[index].selected.toggle()
                                            newElements.append(usersInterests[index])
                                            
                                            print("The new array is : \(newElements)")
                                        }else{
                                            usersInterests[index].selected.toggle()
                                            newElements.removeAll(where: {$0.id == usersInterests[index].id})
                                            print("The new array is : \(newElements)")
                                        }
                                       
                                    }){
                                        ZStack(alignment: .leading){
                                       RoundedRectangle(cornerRadius: 32)
                                               
                                                .foregroundColor(usersInterests[index].selected ? Color(.green) : Color(hue: usersInterests[index].color.hue, saturation: usersInterests[index].color.saturation, brightness: usersInterests[index].color.brightness))
                                                .frame(width: 326,height: 88)
                                            
                                      
                                                Text("\(usersInterests[index].name)")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(Color.white)
                                                    .padding()
                                                
                                                AsyncImage(url: URL(string: usersInterests[index].link)){  image1 in
                                                    
                                                    image1
                                                        .resizable()
                                                        .renderingMode(.template)
                                                        .aspectRatio(contentMode: .fit)
                                                        .foregroundColor(Color.gray)
                                                        .frame(width: 50, height: 50)
                                                        .padding(.leading,240)
                                                }
                                            placeholder: {
                                                ProgressView()
                                                    .frame(width: 50, height: 50)
                                                
                                            }
                                                
                                                
                                                
                                                
                                            
                                        
                                    }
                                        .frame(width: 326,height: 88)
                                    }
                        
                                }
                    
                }
            }
            .padding(.top, 140)
            .frame(width: .infinity,height: .infinity,alignment: .top)
            VStack(alignment: .leading){
                Text("Pick your interests").font(.title).bold()
                Text("You can choose more than one")
                    .font(.footnote).opacity(0.5)
                 
            }
            .padding(.top, 80)
            .padding(.bottom, 20)
            .background(Color.white.opacity(0.975).blur(radius: 10).ignoresSafeArea())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
               
            
            
        }
        
     
        Button(action: {
            finalArray = functions.arrangeArrays(elements: newElements, categories: categoriess)
            if !newElements.isEmpty {
                showArray = true
            }
            
        }){
            ZStack{
                RoundedRectangle(cornerRadius: 34)
                    .foregroundColor(Color(.blue))
                    .frame(width: 342,height: 65)
            Text("Continue")
                .foregroundColor(Color.white)
                
        }
               
        }
    }

}
struct InterestView: View {
    @ObservedObject var interests = InterestsModel()
    @ObservedObject var categories = CategoryModel()
    @Binding var showInterests : Bool
    @Binding var usersInterests : [Element]
    @Binding var categoriess : [Categories]
    
    
    
    var body: some View {
      
            Button(action: {
            usersInterests = interests.getInterests()
            categoriess = categories.getCategories()
                print("The interest are \(usersInterests)")
                print("Fetched categories are \(categoriess)")
                if !usersInterests.isEmpty{
                    showInterests = true
                }
            }){
                
                Text("Get categories")
                    .frame(width: 200)
                    .cornerRadius(30)
                    .foregroundColor(Color.white)
                    .padding()
                    .background(Color(.blue).opacity(0.5))
            }
        
        
    }
}





struct Category : Identifiable{
    var name: String
    var id : Int
}

struct ColorRGB : Codable{
    var red: Double
    var green: Double
    var blue: Double
}


    


//
//  HomeViewModel.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/06.
//

import SwiftUI
import CoreData

class HomeViewModel : ObservableObject{
    
    @Published var content = ""
    @Published var date = Date()
    @Published var title = ""
    
    // For NewData Sheet...
    @Published var isNewData = false
    @Published var isNewContext = false
    
    //Checking And Updating Date...
    
    @Published var updateItem : Task!
    
    let calender = Calendar.current
    
    func checkDate()->String{
        
        if calender.isDateInToday(date){
            
            return "Today"
        }
        else if calender.isDateInTomorrow(date){
            return "Tomorrow"
        }
        else{
            return "Other day"
        }
    }
    
    func updateDate(value: String){
        
        date = Date()
        /*if value == "Today"{date = Date()}
        else if value == "Tomorrow"{
            date = calender.date(byAdding: .day, value: 1, to: Date())!
        }
        else{
            // do something...
            
        }*/
        
    }
    
    func writeData(context : NSManagedObjectContext){
        
        // Updating Item...
        
        if updateItem != nil{
            
            // Means Update Old Data...
            updateItem.date = date
            updateItem.title = title
            updateItem.content = content
            
            try! context.save()
            
            // removing updatingItem if successful
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            title = ""
            date = Date()
            return
            
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.title = title
        newTask.content = content
        
        // saving data...
        
        do{
            
            try context.save()
            // success means closing view...
            isNewData.toggle()
            content = ""
            title = ""
            date = Date()
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    func writeContent(context: NSManagedObjectContext){
        
        if updateItem != nil{
            
            // Means Update Old Data...
            updateItem.date = date
            updateItem.content = content
            
            try! context.save()
            
            // removing updatingItem if successful
            /*updateItem = nil
            content = ""
            title = ""
            date = Date()*/
            return
            
        }
        
        do{
            
            try context.save()
            // success means closing view...
            /*content = ""
            title = ""
            date = Date()*/
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    func EditItem(item: Task){
    
        updateItem = item
        // togging the newDataView...
        date = item.date!
        title = item.title!
        content = item.content!
        isNewData.toggle()
        
    }
    
    func EditContent(item: Task){
    
        updateItem = item
        // togging the newDataView...
        date = item.date!
        title = item.title!
        content = item.content!
        isNewContext.toggle()
        
    }
}

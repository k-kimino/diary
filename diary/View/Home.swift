//
//  Home.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/06.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    // Fetching Data...
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 10){
                
                /*HStack{
                    Text("日記")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)*/
                
                HStack(spacing: 15){
                    
                    Text("日記")
                        .foregroundColor(.black)
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                //Empty View...
                
                if results.isEmpty{
                    
                    //Spacer()
                    
                    Text("")
                    Text("")
                    Text("")
                    Text("まだ日記はありません")
                        .font(.body)
                        .foregroundColor(.gray)
                        .fontWeight(.heavy)
                    
                    Spacer()
                }
                
                else{
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading, spacing: 20){
                            
                            ForEach(results){task in
                                
                                HStack(alignment: .center, spacing: 5, content: {
                                    
                                    //Text(task.date ?? Date(), style: .date)
                                    //    .fontWeight(.bold)
                                    
                                    Button(action: {homeData.EditContent(item: task)
                                        
                                    }, label:{
                                            
                                            VStack{
                                                Text(DayFunc(from: task.date ?? Date()))
                                                    .font(.headline)
                                                    .fontWeight(.bold)
                                                Text(WeekdayFunc(from: task.date ?? Date()))
                                                    .font(.body)
                                                    .fontWeight(.bold)
                                            }
                                            .foregroundColor(Color("Color1"))
                                            .padding()
                                            
                                            Text(task.title ?? "")
                                                .font(.title)
                                                .foregroundColor(.black)
                                                //.fontWeight(.bold)
                                            
                                            Spacer()
                                    })

                                    NavigationLink(destination: PageView(homeData: homeData), isActive: $homeData.isNewContext){
                                        
                                        EmptyView()
                                        
                                    }
                                    
                                    
                                })
                                .background(Color("Color"))
                                .cornerRadius(8)
                                .contextMenu{
                                    
                                    Button(action: {homeData.EditItem(item: task)}, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        
                                        context.delete(task)
                                        try! context.save()
                                        
                                    }, label: {
                                        Text("Delete")
                                    })
                                    
                                }
                                
                            }
                        }
                        .padding()
                        
                    })
                }
            }
            
            // Add Button...
            
            Button(action: {homeData.isNewData.toggle()}, label: {
                
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                    
                        Color("Color1")
                        //AngularGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), center: .center)
                    )
                    .clipShape(Circle())
                
            })
            .padding()
            
        })
        //.ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.0).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            
            NewDataView(homeData: homeData)
            
        })
    }
    
    func WeekdayFunc(from date:Date)->String{
           let cal = Calendar(identifier: .japanese)

           let timeVal = cal.dateComponents([.weekday], from: date)
           let weekDays:[String] = ["","(日)","(月)","(火)","(水)","(木)","(金)","(土)"]
           let weedstr = weekDays[timeVal.weekday ?? 00]

           return weedstr

        }
    
    func DayFunc(from date:Date)->String{
           let cal = Calendar(identifier: .japanese)

        let timeVal = cal.dateComponents([.month,.day], from: date)

        return String(format: "%d/%d", timeVal.month ?? 00, timeVal.day ?? 00)

        }
}

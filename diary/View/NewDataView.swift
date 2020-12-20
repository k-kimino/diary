//
//  NewDataView.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/06.
//

import SwiftUI

struct NewDataView: View {
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        VStack{
            
            HStack{
                
                Text("\(homeData.updateItem == nil ? "新しい日記" : "タイトル更新")")
                    //.font(.system(size: 65))
                    .font(.headline)
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            Text("日記タイトル")
            
            TextEditor(text: $homeData.title)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))
                .padding()
            
            Spacer()
            
            /*Divider()
                .padding(.horizontal)
            
            HStack{
                
                Text("when")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
            }
            .padding()
            
            HStack(spacing: 10){
                
                DataButton(title: "Today", homeData: homeData)
                
                DataButton(title: "Tomorrow", homeData: homeData)
                
                // Data Picker...
                
                DatePicker("", selection: $homeData.date, displayedComponents: .date)
                    .labelsHidden()
            }
            .padding()*/
            
            // Add Button...
            
            Button(action: {homeData.writeData(context: context)}, label: {
                
                Label(
                    title: { Text(homeData.updateItem == nil ? "追加する" : "更新する")
                        .font(.title2)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    },
                    icon: { Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                    })
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 30)
                    .background(
                    
                        Color("Color1")
                        /*LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]),
                                       startPoint: .leading, endPoint: .trailing)*/
                    )
                    .cornerRadius(8)
                
            })
            
            // disabling button when no data...
            .disabled(homeData.title == "" ? true : false)
            .opacity(homeData.title == "" ? 0.5 : 1)
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .bottom))
    }
    
}

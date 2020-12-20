//
//  PageView.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/12.
//

import SwiftUI
import CoreData

struct PageView: View {
    
    @ObservedObject var homeData : HomeViewModel
    @Environment(\.presentationMode) var present
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack(spacing: 20){
                
                Button(action: {present.wrappedValue.dismiss()}){
                    
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color("Color1"))
                }
                
                Spacer()
                
                Text(homeData.title)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {homeData.writeContent(context: context)
                    
                }, label: {
                    
                    Text("完了")
                        .foregroundColor(Color("Color1"))
                    
                })
                
                
            }
            .padding([.horizontal,.top])
            
            Divider()
            
            TextEditor(text: $homeData.content)
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                /*.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1))*/
            
            Spacer()
        }
        //.ignoresSafeArea(.all, edges: .top)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color.black.opacity(0.0).ignoresSafeArea(.all, edges: .all))
        
    }
}


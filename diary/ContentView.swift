//
//  ContentView.swift
//  diary
//
//  Created by 君野敬祐 on 2020/12/06.
//

import SwiftUI
import CoreData

struct ContentView: View {

    init(){
        
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        NavigationView{
            Home()
                //.navigationTitle("日記")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        
        //PageView()
    }

}

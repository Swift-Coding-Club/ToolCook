//
//  ContentView.swift
//  pastar
//
//  Created by sueun kim on 2023/02/23.
//
import SwiftUI

struct ContentView: View {
    @State private var selection = 0
       var body: some View {
           TabView {
               Text("First Tab")
                   .tabItem {
                       Image(systemName: "1.square.fill")
                       Text("First")
                           .tag(0)
                   }
                Text("Second Tab")
                   .tabItem {
                       Image(systemName: "2.square.fill")
                       Text("Second")
                           .tag(1)
                   }
                    Text("조엘")
                   .tabItem {
                       Image(systemName: "3.square.fill")
                       Text("조앨")
                           .tag(2)
                   }
                    SuhaTabView()
                   .tabItem {
                       Image(systemName: "4.square.fill")
                       Text("수하")
                           .tag(3)
                   }
           }
       }
   }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

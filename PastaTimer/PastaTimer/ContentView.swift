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
            MandoTabView()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Mando")
                        .tag(0)
                }
            RxTabView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Rx")
                        .tag(1)
                }
            JoelTabView()
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

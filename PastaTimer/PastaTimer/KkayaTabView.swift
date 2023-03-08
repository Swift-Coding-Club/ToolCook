//
//  KkayaTabView.swift
//  PastaTimer
//
//  Created by saya lee on 2023/03/09.
//

import SwiftUI

struct KkayaTabView: View {
    var body: some View {
        VStack {
            
            HStack{
                VStack{
                    Image("penne").resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(250)
                        .aspectRatio( contentMode: .fit)
                        .padding()
                    
                    Text("펜네").font(.system(size: 30))
                }
                
                VStack{
                    Image("Fusilli").resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(250)
                        .aspectRatio( contentMode: .fit)
                        .padding()
                    
                    Text("푸실리").font(.system(size: 30))
                }
                
                VStack{
                    Image("spaghetti").resizable()
                        .frame(width: 250, height: 250)
                        .cornerRadius(250)
                        .aspectRatio( contentMode: .fit)
                        .padding()
                    
                    Text("스파게티").font(.system(size: 30))
                }

            }
        }.padding()

    }
}

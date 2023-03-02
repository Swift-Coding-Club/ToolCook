//
//  SuhaTabView.swift
//  PastaTimer
//
//  Created by sueun kim on 2023/02/28.
//

import SwiftUI

struct SuhaTabView: View {
    var body: some View {
        ZStack{
            Color("backgroundColor").ignoresSafeArea(.all)
            VStack{
                Text("파스타 타이머🍝")
                    .font(.system(size:25))
                    .bold()
                    .padding(.top,60)
                Text("👩🏻‍🍳")
                    .font(.system(size:40))
                    .padding(.top,30)
                StartStop()
                Spacer()
            }
        }
    }
}

struct SuhaTabView_Previews: PreviewProvider {
    static var previews: some View {
        SuhaTabView()
    }
}

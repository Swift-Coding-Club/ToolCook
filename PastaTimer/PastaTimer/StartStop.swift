//
//  start_stop.swift
//  pastar
//
//  Created by sueun kim on 2023/02/23.
//

import SwiftUI

struct StartStop: View {
    @State private var PastaStateButton : Bool = true
    @State var ResetButton : Bool = false
    @State var Duration : TimeInterval = 60 * 10
    
    var body: some View {
        VStack{
            TimerView(PastaStateButton: $PastaStateButton, ResetButton: $ResetButton,TimeRating : $Duration, duration: Duration)
                    HStack{
                        Button {
                            PastaStateButton.toggle()
                        } label: {
                            Text(PastaStateButton ? "Start" : "Stop")
                                .foregroundColor(.white)
                                .font(.system(size:25))
                                .frame(width: 100,height: 50)
                                .background(PastaStateButton ? Color("startColor") : Color(.red))
                                .cornerRadius(75)
                                .padding(.trailing,25)
                                .bold()
                        }
                        Button{
                        }label: {
                            Text("Reset")
                                .foregroundColor(.white)
                                .frame(width: 100,height: 50)
                                .background(.orange)
                                .cornerRadius(75)
                                .font(.system(size:25))
                                .padding(.leading,25)
                                .bold()
                        }
                    }
                }
        }
}
struct StartStop_Previews: PreviewProvider {
    static var previews: some View {
        StartStop()
    }
}

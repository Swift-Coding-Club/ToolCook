//
//  timerView.swift
//  pastar
//
//  Created by sueun kim on 2023/02/23.
//
import SwiftUI

struct TimerView: View {
    @Binding var PastaStateButton: Bool
    @Binding var ResetButton: Bool
    @Binding var TimeRating : TimeInterval
    @State private var elapsedTime: TimeInterval = 0
    
    @State var PastaButton : [PastaSelector] = [.pasta1,.pasta2,.pasta3]
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let duration: TimeInterval
    var remainingTime: TimeInterval {
        max(duration - elapsedTime, 0)
    }
    enum PastaSelector{
        case pasta1, pasta2, pasta3
        var PastaName : String {
            switch self {
            case .pasta1:
                return "pasta1"
            case .pasta2:
                return "pasta2"
            case .pasta3:
                return "pasta3"
            }
        }
        var PastaColor : Color {
            switch self{
            case .pasta1:
                return Color("pastar1Color")
            case .pasta2:
                return Color("pastar2Color")
            case .pasta3:
                return Color("pastar3Color")
            }
        }
    }
        var body: some View {
            VStack{
                Text("\(Int(remainingTime / 60)):\(Int(remainingTime) % 60, specifier: "%02d")")
                    .foregroundColor(.black)
                    .font(.system(size:65))
                    .italic()
                    .onReceive(timer) { _ in
                        if PastaStateButton {
                            timer.upstream.connect().cancel()
                        }else if elapsedTime < duration {
                            elapsedTime += 1
                        }else if PastaStateButton {
                            timer.upstream.connect().cancel()
                        }else if ResetButton {
                            timer.upstream.connect().cancel()
                        }
                    }
                ZStack{
                    Color(.gray)
                        .frame(width: 300,height: 120)
                        .cornerRadius(40)
                    VStack{
                        Text("면 종류를 선택해 주세요")
                            .padding(.top,50)
                        HStack{
                            ForEach(PastaButton,id:\.self){ Pasta in
                                Button {
                                    if Pasta.PastaName == "pasta1"{
                                        TimeRating = 60 * 10
                                    } else if Pasta.PastaName == "pasta2"{
                                        TimeRating = 60 * 15
                                    }else if  Pasta.PastaName == "pasta3"{
                                        TimeRating = 60 * 8
                                    }
                                } label: {
                                    Text(Pasta.PastaName)
                                        .foregroundColor(.black)
                                        .frame(width: 80,height: 30)
                                        .background(Pasta.PastaColor)
                                        .cornerRadius(40)
                                        .padding(.bottom,50)
                                }
                            }
                        }
                    }
                }
            }
        }
    }


struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        StartStop()
    }
}

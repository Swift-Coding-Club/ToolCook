//
//  ContentView.swift
//  PastaTimerApp
//
//  Created by 강동영 on 2023/02/25.
//

import SwiftUI

struct Clock: View {
    @Binding var counter: Int
    @Binding var countTo: Int
    @Binding var isConnectedTimer: Bool
    
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.custom("Avenir Next", size: 60))
                .fontWeight(.black)
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        print("currentTime = \(currentTime), countTo - counter = \(countTo) \(counter)")
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct RxTabView: View {
    
    @State var timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    @State private var selectedValue: PastaType = .스파게티
    @State private var isShowingPicker = false
    @State private var isStartTimer = false
    @State var counter: Int = 0
    @State var countTo: Int = 600
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Clock(counter: $counter, countTo: $countTo, isConnectedTimer: $isStartTimer)
                    
                Spacer()
                
                Button("\(self.selectedValue.rawValue)") {
                    isShowingPicker.toggle()
                    countTo = selectedValue.time
                }
                
                Spacer()
                
                HStack {
                    Button("초기화") {
                        counter = countTo
                    }
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .background(Color.gray)
                    .clipShape(Circle())
                    Spacer()
                    Button("\(isStartTimer ? "그만" : "시작")") {
                        if isStartTimer {
                            stopTimer()
                        } else {
                            startTimer()
                        }
                        self.isStartTimer.toggle()
                    }
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color.black)
                    .background(isStartTimer ? Color.red : Color.green)
                    .clipShape(Circle())
                } // HStack
                .padding()
                
                Spacer()
            } // VStack
            .padding()
            .onReceive(timer) { time in
                guard isStartTimer else { return }
                
                if (self.counter < self.countTo) {
                    self.counter += 1
                }
            }
            
            PickerView(selection: $selectedValue,
                       inShowing: $isShowingPicker)
            .animation(.linear)
            .offset(y: self.isShowingPicker ? 0 : UIScreen.main.bounds.height)
            
        }
    }
    
    private func startTimer() {
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
    }
    
    private func stopTimer() {
        timer.upstream.connect().cancel()
    }
}

struct PickerView: View {
    
    @Binding var selection: PastaType
    @Binding var inShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                self.inShowing = false
            } label: {
                HStack {
                    Spacer()
                    Text("닫기")
                }
            }

            Picker("Choose a Pasta", selection: $selection) {
                ForEach(PastaType.allCases, id: \.self) {
                    Text($0.rawValue)
                    }
                  }
                  .pickerStyle(.wheel)
        }
        
    }
}

struct RxTabView_Previews: PreviewProvider {
    static var previews: some View {
        RxTabView()
    }
}

enum PastaType: String, CaseIterable {
    case 스파게티
    case 페투치네
    case 펜네
    case 마카로니
    case 후실리
    case 라자냐
    case 뇨키
    case 라비올리
    
    var time: Int {
        switch self {
        case .스파게티:
            return 600
        case .페투치네:
            return 420
        case .펜네:
            return 660
        case .마카로니:
            return 900
        case .후실리:
            return 660
        case .라자냐:
            return 480
        case .뇨키:
            return 600
        case .라비올리:
            return 480
        }
    }
}

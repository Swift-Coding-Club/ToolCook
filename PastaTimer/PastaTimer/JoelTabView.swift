import SwiftUI

struct JoelTabView: View {
    let pastaTypes = ["카펠리니", "스파게티", "페투치네", "펜네", "푸실리"]
    let times = [2, 10, 7, 4, 3] // 분
    
    @State private var selectedPastaIndex = -1 // unselect를 위해 -1
    @State private var timeRemaining: Int // 0초로 초기화
    @State private var timer: Timer?
    @State private var timerIsRunning = false


    
    init() {
        self.selectedPastaIndex = -1
        self.timeRemaining = 0
        
        if selectedPastaIndex >= 0 {
            self.timeRemaining = times[selectedPastaIndex] * 60 // 선택한 파스타 유형 시간(초)로 초기화
        }
    }

    
    var body: some View {
        VStack {
            Text(String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)) // 시간 형식 mm:ss
                .frame(width: 285, height: 130)
                .font(.system(size: 110, weight: .thin))
                .padding(40)
            VStack {
                HStack {
                    ForEach(0..<3) { i in
                        Button(action: {
                            self.selectedPastaIndex = i
                            self.timeRemaining = self.times[i] * 60 // 남은 시간을 초 단위로 설정
                        }) {
                            Text("\(self.pastaTypes[i])")
                                .frame(width: 105, height: 105, alignment: .center)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(selectedPastaIndex == i ? .black : .white)
                                .background(selectedPastaIndex == i ? Color("SelectedColor") : Color("UnselectedColor"))
                                .clipShape(Circle())
                                .padding(5)
                        }
                    }
                }
                HStack {
                    ForEach(3..<5) { i in
                        Button(action: {
                            self.selectedPastaIndex = i
                            self.timeRemaining = self.times[i] * 60
                        }) {
                            Text("\(self.pastaTypes[i])")
                                .frame(width: 105, height: 105, alignment: .center)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundColor(selectedPastaIndex == i ? .black : .white)
                                .background(selectedPastaIndex == i ? Color("SelectedColor") : Color("UnselectedColor"))
                                .clipShape(Circle())
                                .padding(5)
                        }
                    }
                }
            }
            .padding(40)
            .disabled(timerIsRunning)
            
            HStack(spacing: 160) {
                Button(action: {
                    guard self.selectedPastaIndex >= 0 else {
                        return
                    }
                    self.timerIsRunning = true
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        if self.timeRemaining > 0 {
                            self.timeRemaining -= 1
                        } else {
                            self.timer?.invalidate()
                            self.timerIsRunning = false
                        }
                    }
                }) {
                    Text("START")
                        .font(.system(size: 20, weight: .regular))
                        .padding()
                        .foregroundColor(.black)
                }
                .frame(width: 97, height: 44)
                .background(Color("UnselectedColor"))
                .cornerRadius(50)
                .disabled(timerIsRunning) // timeIsRunning이 true면 disable

                
                Button(action: {
                    self.selectedPastaIndex = -1 // 선택을 재설정하기 위해 -1로
                    self.timeRemaining = 0 // 리셋 타임을 00:00으로 만들기
                }) {
                    Text("CLEAR")
                        .font(.system(size: 20, weight: .regular))
                        .padding()
                        .foregroundColor(.black)
                }
                .frame(width: 97, height: 44)
                .background(Color("UnselectedColor"))
                .cornerRadius(50)
            }
        }
    }
}

//
//  MandoTabView.swift
//  PastaTimer
//
//  Created by 안윤진 on 2023/03/06.
//

import SwiftUI

/*
    어려웠던 점
    1. 타이머: 첫 사용이라 많이 어려웠다.
    2. ObservableObject: 멀티뷰에서 같은 데이터를 다뤄야함> 관성처럼 @AppCoreData를 사용하다가 문득 로컬에 저장할 필요가 없다는 것을 알고 바꿨다.
        이것도 첫 사용.
 EnvironmentViewModel: publisher -> MainView: 인자로 viewModel 전달 -> TimerView: 파스타를 선택했을 때에만 종류에 맞는 시간+타이머뷰 보여줌
    StateObject는 작동 중화면을 다시 그리지 않을 때, ObservedObject는 화면을 다시 그려야할 때 사용한다고 들어서 파스타를 클릭하는 화면(MainView)에는 StateObject를 사용, 클릭한 버튼 인덱스에 따라 타이머를 새로 그려야 하는 TimerView에는 ObservedObject를 사용.
 */
class EnvironmentViewModel : ObservableObject{
    @Published var title: [String] = []
    @Published var time: [Int] = [] //조리시간
    @Published var isClicked: [Bool] = [] //클릭여부
    @Published var backgroundColor: [Color] = []
    @Published var rightIndex: Int = 0
    //클릭여부에 따른 배경색상
    
    init() {
        getData()
    }
    
    func getData() {
        title.append(contentsOf: [" 토마토 \n 파스타"," 알리오 \n 올리오"," 상하이 \n 파스타"])
        time.append(contentsOf: [540,700,600])
        isClicked.append(contentsOf: [false, false, false])
        backgroundColor.append(contentsOf: [Color("greenbutton"), Color("greenbutton"), Color("greenbutton")])
    }
}

struct MandoTabView: View {
    
    @StateObject var viewModel: EnvironmentViewModel = EnvironmentViewModel()
    
    
    var body: some View {
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            VStack(spacing:50) {
                HStack(spacing:20){
                    ForEach(viewModel.title.indices, id: \.self) { index in
                        Button(action: {
                            //다른 모든 버튼이 선택되지 않았을 때만 참이 되는 변수
                            let allOtherButtonsNotClicked = self.viewModel.isClicked.filter { $0 }.count == 0
                            if allOtherButtonsNotClicked || self.viewModel.isClicked[index] {
                                self.viewModel.isClicked[index].toggle()
                                if self.viewModel.isClicked[index] {
                                    self.viewModel.backgroundColor[index] = Color("pink")
                                    self.viewModel.rightIndex = index
                                } else {
                                    self.viewModel.backgroundColor[index] = Color("greenbutton")
                                }
                            }
                        }, label: {
                            Text("\(self.viewModel.title[index])")
                                .frame(width: 100, height: 100)
                                .background(self.viewModel.backgroundColor[index])
                                .foregroundColor(Color("outline"))
                                .clipShape(Circle())
                                .overlay(
                                    RoundedRectangle(cornerRadius: 50)
                                        .stroke(Color("outline"), lineWidth: 2)
                                )
                        })
                    }
                }
                Spacer(minLength: 100)
                if !self.viewModel.isClicked[0] && !self.viewModel.isClicked[1] && !self.viewModel.isClicked[2]{
                    Text("파스타를\n선택하세요")
                        .font(.system(size: 44, weight: .regular))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("outline"))
                    Spacer(minLength: 200)
                }
                else{
                    MandoTimerView(viewModel: viewModel)

                }
                
                
            }
        }
    }
    
}

struct MandoTimerView: View {
    @ObservedObject var viewModel: EnvironmentViewModel //주석 1 참고
    @State var secondsLeft: Int = 0
    @State var timer: Timer?
    @State var isTimerActive: Bool = false //타이머를 활성화하는 변수
    var timeLimit: Int = 100
    var selectedIndex: Int = 0 { //선택된 파스타 버튼의 인덱스
    didSet {
                    // selectedIndex가 바뀌면 초기화
                    self.secondsLeft = viewModel.time[selectedIndex]
                    self.timeLimit = viewModel.time[selectedIndex]
                    self.timer?.invalidate()
                    self.isTimerActive = false
                }
    }

    init(viewModel: EnvironmentViewModel) {
        //viewModel을 인자로 받아 초기화
                self.viewModel = viewModel //주석 1: StateObject로 받으면 self.~으로 초기화할 수 없어서 ObservedObject로 선언
                self.selectedIndex = viewModel.isClicked.firstIndex(of: true) ?? 0
                _secondsLeft = State(initialValue: viewModel.time[selectedIndex])
                timeLimit = viewModel.time[selectedIndex]
            }
    
    var body: some View{
        VStack{
            Text("\(secondsLeftToMinutesSeconds(seconds:secondsLeft))")
                .font(.system(size: 64, weight: .semibold))
                .foregroundColor(Color("outline"))
                .multilineTextAlignment(.center)
            Spacer()
            HStack(spacing:16){
                Button(action: {
                    self.secondsLeft = timeLimit
                    isTimerActive = false
                }){
                    Image("resetIcon")
                        .resizable()
                        .frame(width: 22.0, height: 22.0)
                }.buttonStyle(SubButton())
                
                Button(action: {
                    if !isTimerActive {
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            if secondsLeft > 0 {
                                secondsLeft -= 1
                            } else {
                                //0초 이하의 시간이 남았다면 멈춤
                                timer?.invalidate()
                                isTimerActive = false
                            }
                        }
                        isTimerActive = true
                    }
                }){
                   Image("startIcon")
                        .resizable()
                        .frame(width: 22.0, height: 22.0)
                }.buttonStyle(StartButton())
                
                Button(action: {
                    // 타이머 멈춤
                    timer?.invalidate()
                    isTimerActive = false
                }) {
                    Image("pauseIcon")
                        .resizable()
                        .frame(width: 22.0, height: 22.0)
                }.buttonStyle(SubButton())
            }
        }
    }
    //초를 받아 분:초 스트링으로 바꿔 변환
            func secondsLeftToMinutesSeconds(seconds: Int) -> String {
                let minutes = (seconds % 3600) / 60
                let seconds = (seconds % 3600) % 60
                return String(format: "%02d:%02d", minutes, seconds)
            }
            
        }


//버튼 스타일
struct StartButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 128, height: 96)
            .foregroundColor(Color.black)
            .background(Color("pink"))
            .cornerRadius(32)
        
        
    }
}

struct SubButton: ButtonStyle {
func makeBody(configuration: Configuration) -> some View {
    configuration.label
        .frame(width: 80, height: 80)
        .foregroundColor(Color.black)
        .background(Color("lightpink"))
        .cornerRadius(24)
        
        
}
}


struct MandoTabView_Previews: PreviewProvider {
    static var previews: some View {
        MandoTabView()
    }
}

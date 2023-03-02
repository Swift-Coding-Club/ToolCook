//
//  PlayerView.swift
//  MusicPlaylist
//
//  Created by 안윤진 on 2023/03/02.
//

import SwiftUI

struct ProgressBar: View{
    var width: CGFloat = 300
    var height: CGFloat = 9
    var percent: CGFloat = 69
    let lineargradient = LinearGradient(gradient: Gradient(colors: [ Color("ProgressStart"),Color("ProgressEnd")]),
                                      startPoint: .leading,
                                      endPoint: .trailing)
    var body: some View{
        let multiplier = width/100
        ZStack(alignment: .leading){ //프로그레스 바
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .frame(width:width, height: height)
                .foregroundColor(Color.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: 20,style: .continuous)
                .frame(width:percent*multiplier, height: height)
                .background(lineargradient)
                .clipShape(RoundedRectangle(cornerRadius: 20,style: .continuous)
                )
                .foregroundColor(.clear)
        }
        
    }
}
struct PlayerView: View {
    @State var isPlaying : Bool = false
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                AngularGradient(colors: [Color("AngularFirst"),Color("AngularSecond"),Color("AngularThird"),Color("AngularFourth"),Color("AngularFifth"),Color("AngularSixth")], center: .topLeading)
                    .ignoresSafeArea(.all)
            
                VStack(){
                    HStack(){
                        Spacer().frame(width: 24)
                        Button{
                            dismiss()
                        } label: {
                            Image("GoBackButton")
                                .resizable()
                                .frame(width: 48.0, height: 48.0)
                        }
                        Spacer()
                        Text("Now Playing")
                            .font(.system(size:18))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Spacer()
                        Button{} label: {
                            Image("ListButton")
                                .resizable()
                                .frame(width: 48.0, height: 48.0)
                        }
                        Spacer().frame(width: 24)
                    }
                    Spacer()
                    Image("PlayingImage")
                        .resizable().frame(width: 300.0, height: 300.0)
                    Text("Girl like me")
                        .font(.system(size:34))
                        .fontWeight(.bold)
                    Text("Shakira ft Black Eyed peas")
                        .font(.system(size:13))
                    Spacer()
                    ProgressBar()
                    Spacer()
                    HStack(spacing:20){
                        Button{

                        } label:{
                            Image("RewindButton").resizable().frame(width: 68.0, height: 68.0)
                        }
                        Button{
                            self.isPlaying.toggle()
                        } label:{
                            Image(self.isPlaying == true ? "StartButton":"StopButton").resizable().frame(width: 68.0, height: 68.0)
                        }
                        Button{

                        } label:{
                            Image("SkipButton").resizable().frame(width: 68.0, height: 68.0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    
                }.foregroundColor(Color("BlueGray"))
            }.navigationBarBackButtonHidden()
            
        }}
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}

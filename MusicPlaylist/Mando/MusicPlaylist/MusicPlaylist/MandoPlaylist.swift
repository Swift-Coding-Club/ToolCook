//
//  ContentView.swift
//  MusicPlaylist
//
//  Created by 안윤진 on 2023/03/01.
//
/*
    수요일: 피그마에서 정한 ui대로 화면만 완성
    목요일:
 */

/*
    해야할 일
    1. 플레이리스트화면과 플레이 화면 모두에서 재생버튼 눌렀을 때 toggle 로컬에 저장
    2. 프로그레스바
    기타) 하트 여부 저장
 */
import SwiftUI
struct Music: Identifiable, Hashable{
    var id = UUID()
    let title: String
    let artist: String
    let liked: Bool
    let image: String
}

// 음악 재생 코드
 import AVFoundation

 var player: AVAudioPlayer?

 func playSound() {
     guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }

     do {
         try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
         try AVAudioSession.sharedInstance().setActive(true)

          //The following line is required for the player to work on iOS 11. Change the file type accordingly
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

         /* iOS 10 and earlier require the following line:
         player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

         guard let player = player else { return }

         player.play()

     } catch let error {
         print(error.localizedDescription)
     }
 }


struct MandoPlayList: View {
    @State private var showPlayer = false
    let songs: [Music] = [
        .init(title: "A Glimmer Of Light",artist: "Darley Masterclass",liked: false,image: "PlayingImage"),
        .init(title: "Diamond Dreams",artist: "Lazy Lewis",liked: false,image: "PlayingImage"),
        .init(title: "Chantaje",artist: "Gigolo & La Exce",liked: false,image: "PlayingImage"),
        .init(title: "White Winds",artist: "Lazy Lewis",liked: false,image: "PlayingImage"),
        .init(title:"Redline",artist: "김윤서",liked: false,image: "PlayingImage"),
        .init(title: "Flatline",artist: "김윤서",liked: false,image: "PlayingImage")
    ]
    var body: some View {
        NavigationStack {
            VStack(spacing:20) {
                
                Text("El Dorado")
                    .font(.system(size: 24))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                Text("Shakira").font(.system(size: 34)).fontWeight(.semibold)
                                
                            }
                        }
                    }
                Spacer()
                Image("PlayListImage")
                    .resizable().frame(width: 300.0, height: 300.0)
                HStack(){
                    Spacer().frame(width: 24)
                    Text("My playlist")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                List(songs){
                    song in
                    HStack{
                        Button{
                            showPlayer = true
                        } label:{
                            Image("PlayButton").resizable().frame(width: 30.0, height: 30.0)
                        }
                        
                        Text(song.title)
                        Spacer()
                        
                        Button{
                            
                        } label:{
                            Image("LikeButton").resizable().frame(width: 30.0, height: 30.0)
                        }
                        
                        
                    }
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .listRowBackground(Color.clear)//listrow각각의 배경색상 숨김
                    .listRowSeparator(.hidden)//list separator 삭제
                }.listStyle(PlainListStyle()) //list 양 옆의 마진을 없앰
                    .scrollContentBackground(.hidden)//list의 배경색상 숨김
                
                HStack(){
                    Button{

                    } label:{
                        Image("HomeButton").resizable().frame(width: 44.0, height: 44.0)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(Color("TapBar"))
                
            }
            .foregroundColor(Color("BlueGray"))
            .background(            AngularGradient(colors: [Color("AngularFirst"),Color("AngularSecond"),Color("AngularThird"),Color("AngularFourth"),Color("AngularFifth"),Color("AngularSixth")], center: .topLeading)
                .ignoresSafeArea(.all))
            .fullScreenCover(isPresented: $showPlayer){
                PlayerView()
            }
        }
        
    }
        
}
struct MandoPlayList_Previews: PreviewProvider {
    //static let musicVM = MusicViewModel(music: Music.data)
    static var previews: some View {
        MandoPlayList()
    }
}

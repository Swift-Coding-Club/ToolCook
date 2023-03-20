//
//  TestPlay.swift
//  MusicPlaylist
//
//  Created by sueun kim on 2023/03/10.
//
import SwiftUI
import AVKit

struct TestPlay: View {
    @State var audioPlayer: AVAudioPlayer!
    var body: some View {
            VStack {
                    Text("Play").font(.system(size: 45)).font(.largeTitle)
                HStack {
                    Spacer()
                    Button(action: {
                        self.audioPlayer.play()
                    }) {
                        Image(systemName: "play.circle.fill").resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                    Button(action: {
                        self.audioPlayer.pause()
                    }) {
                        Image(systemName: "pause.circle.fill").resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                }
            }
        .onAppear {
            let sound = Bundle.main.path(forResource: "", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
    }
}
struct TestPlay_Previews: PreviewProvider {
    static var previews: some View {
        TestPlay()
    }
}

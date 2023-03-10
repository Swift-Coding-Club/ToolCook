////
////  ContentView.swift
////  MusicPlaylist
////
////  Created by 최진욱 on 2023/03/02.
////
//
//import SwiftUI
//import AVKit
//
////struct ContentView: View {
////    var body: some View {
////        MusicPlayer()
////    }
////}
//
////struct ContentView_Previews: PreviewProvider {
////    static var previews: some View {
////        ContentView()
////    }
////}
//
//struct MusicPlayer: View {
//
//    // Properties
//    @State private var data: Data?
//    @State private var title = ""
//    @State private var artist = ""
//    @State private var albumName = ""
//    @State var player: AVAudioPlayer!
//    @State var playing = false
//    @State var width: CGFloat = 0
//    @State var currentIndex = 0
//
//
//    let musicFileURLs = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "MusicSamples") ?? []
//
//    // Body
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Music player image and title
//                VStack(spacing: 60) {
//                    Image(uiImage: self.data.flatMap(UIImage.init(data:)) ?? UIImage(systemName: "music.note")!)
//                        .resizable()
//                        .frame(width: 358, height: 358)
//
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text(self.title)
//                            .font(.system(size: 24, weight: .semibold))
//                            .lineLimit(1)
//                        Text(self.artist)
//                            .font(.system(size: 16, weight: .regular))
//                            .foregroundColor(Color.gray)
//                            .lineLimit(1)
//                    }
//                    .padding(.leading, 20)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                }
//                .onAppear {
//                    self.playSong(at: self.currentIndex)
//
//                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
//                        if self.player.isPlaying {
//                            DispatchQueue.main.async {
//                                let screen = UIScreen.main.bounds.width - 30
//                                let value = self.player.currentTime / self.player.duration
//                                self.width = screen * CGFloat(value)
//                            }
//                        }
//                    }
//                }
//                .padding(.bottom, 30)
//                // Music player progress bar
//                VStack {
//                    ZStack(alignment: .leading) {
//                        Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
//                        Capsule().fill(Color.green).frame(width: self.width, height: 8)
//                    }
//                    .padding(.horizontal, 20)
//                    HStack {
//                        Text("\(formatTime(self.player?.currentTime ?? 0) )")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 12))
//                        Spacer()
//                        Text("\(formatTime(self.player?.duration ?? 0) )")
//                            .foregroundColor(.gray)
//                            .font(.system(size: 12))
//                    }
//                    .padding(.horizontal, 20)
//                }
//            }
//
//            // Music player controls
//            HStack(spacing: 105) {
//                Button(action: {
//                    self.playPreviousSong()
//                }) {
//                    Image(systemName: "backward").font(.title)
//                }
//                Button(action: {
//                    if self.player.isPlaying {
//                        self.player.pause()
//                        self.playing = false
//                    } else {
//                        self.player.play()
//                        self.playing = true
//                    }
//                }) {
//                    Image(systemName: self.playing ? "pause" : "play").font(.title)
//                }
//                Button(action: {
//                    self.playNextSong()
//                }) {
//                    Image(systemName: "forward").font(.title)
//                }
//            }.padding(.top, 35)
//                .foregroundColor(.black)
//
//        }
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    print("Tap left")
//                } label: {
//                    Label("backward", systemImage: "chevron.backward")
//                        .foregroundColor(.black)
//                }
//            }
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    print("Tap right")
//                } label: {
//                    Label("list", systemImage: "text.justify")
//                        .foregroundColor(.black)
//                }
//            }
//        }
//    }
//
//    // Get metadata from music file
//    private func getData() {
//        guard let url = self.player?.url else {
//            return
//        }
//        let asset = AVAsset(url: url)
//
//        for i in asset.commonMetadata {
//            if i.commonKey?.rawValue == "artwork" {
//                let data = i.value as! Data
//                self.data = data
//            }
//
//            if i.commonKey?.rawValue == "title" {
//                let title = i.value as! String
//                self.title = title
//            }
//
//            if i.commonKey?.rawValue == "artist" {
//                let artist = i.value as! String
//                self.artist = artist
//            }
//
//            if i.commonKey?.rawValue == "albumName" {
//                let albumName = i.value as! String
//                self.albumName = albumName
//            }
//        }
//    }
//
//    // Format time in MM:SS format
//    func formatTime(_ time: TimeInterval) -> String {
//        let minutes = Int(time) / 60
//        let seconds = Int(time) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//
//    // Main function to play music
//    func playSong(at index: Int) {
//        let url = musicFileURLs[index]
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            player.play()
//            playing = true
//            currentIndex = index
//            getData()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
//    // Play next song
//    func playNextSong() {
//        let index = currentIndex + 1 < musicFileURLs.count ? currentIndex + 1 : 0
//        playSong(at: index)
//    }
//
//    // Play previous song
//    func playPreviousSong() {
//        let index = currentIndex - 1 >= 0 ? currentIndex - 1 : musicFileURLs.count - 1
//        playSong(at: index)
//    }
//}
//

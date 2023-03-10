////
////  HomeViewModel.swift
////  MusicPlaylist
////
////  Created by 최진욱 on 2023/03/09.
////
//
//import SwiftUI
//import AVKit
//
//let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil) ?? []
//
//class HomeViewModel : ObservableObject {
//    
//    @Published var player = try! AVAudioPlayer(contentsOf: urls.first!)
//    @Published var isPlaying = false
//    @Published var album = Album()
//    @Published var angle : Double = 0
//    
//   
//    func fetchAlbum() {
//        let asset = AVAsset(url: player.url!)
//        
//        asset.metadata.forEach { (meta) in
//            
//            switch(meta.commonKey?.rawValue) {
//                
//            case "title": album.title = meta.value as? String ?? ""
//            case "artist": album.artist = meta.value as? String ?? ""
//            case "artwork":
//                if let imageData = meta.value as? Data {
//                    album.updateArtwork(with: imageData)
//                }
//            default: ()
//                
//                
//            }
//        }
//    }
//    func onChanged(value: DragGesture.Value) {
//        let vector = CGVector(dx: value.location.x, dy: value.location.y)
//        withAnimation(Animation.linear(duration: 0.1)) {self.angle = Double(angle)}
//    }
//}

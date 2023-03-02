//
//  MusicViewModel.swift
//  MusicPlaylist
//
//  Created by 안윤진 on 2023/03/02.
//

import Foundation
import MediaPlayer
final class Model: ObservableObject{
    static let shared = Model()
    @Published var currentSong: MPMediaItem?
    @Published var playlists = [MPMediaItemCollection]()
    @Published var libararySongs = [MPMediaItem]()
}

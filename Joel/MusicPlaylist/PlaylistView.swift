//
//  PlaylistView.swift
//  MusicPlaylist
//
//  Created by 최진욱 on 2023/03/10.
//

import SwiftUI

struct PlaylistView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: "MusicSamples") ?? []
    
    
    var body: some View {
        NavigationView {
            VStack {
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Label("Backward", systemImage: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }

}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
    }
}

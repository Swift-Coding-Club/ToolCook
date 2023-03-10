////
////  Home.swift
////  MusicPlaylist
////
////  Created by 최진욱 on 2023/03/09.
////
//
//import SwiftUI
//
//struct Home: View {
//    @StateObject var homeData = HomeViewModel()
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 60) {
//            if let artwork = homeData.album.artwork {
//                       Image(uiImage: artwork)
//                           .resizable()
//                           .aspectRatio(contentMode: .fill)
//                           .frame(width: 358, height: 358)
//                           .cornerRadius(10)
//                   } else {
//                       // Provide a default image here
//                       Image(systemName: "music.note")
//                           .resizable()
//                           .aspectRatio(contentMode: .fit)
//                           .frame(width: 358, height: 358)
//                           .foregroundColor(.gray)
//                           .opacity(0.5)
//                           .cornerRadius(10)
//                   }
//                    VStack(alignment: .leading, spacing: 6) {
//                        Text(homeData.album.title)
//                            .font(.system(size: 24, weight: .semibold))
//                        Text(homeData.album.artist)
//                            .font(.system(size: 16, weight: .regular))
//                            .foregroundColor(Color.gray)
//                    }
//                    .padding(.trailing, 274)
//                }
//                .padding(.bottom, 30)
//                
//                ZStack(alignment: .leading) {
//                    Capsule().fill(Color.black.opacity(0.08)).frame(height: 8)
//                    Capsule().fill(Color.green).frame(width: 200, height: 8)
//                        .gesture(DragGesture().onChanged(homeData.onChanged(value:)))
//                }
//                .padding(.horizontal, 20)
//                
//                HStack(spacing: 105) {
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "backward").font(.title)
//                    }
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "play").font(.title)
//                    }
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "forward").font(.title)
//                    }
//                }.padding(.top, 35)
//                
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        print("Tap left")
//                    } label: {
//                        Label("backward", systemImage: "chevron.backward")
//                            .foregroundColor(.black)
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        print("Tap right")
//                    } label: {
//                        Label("list", systemImage: "text.justify")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
//        }
//    }

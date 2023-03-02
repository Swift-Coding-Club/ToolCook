import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    var body: some View {
        TabView {
            Text("First Tab")
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                        .tag(0)
                }
            RxTabView()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                        .tag(1)
                }
            JoelTabView()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("조앨")
                        .tag(2)
                }
            Text("Fourth Tab")
                .tabItem {
                    Image(systemName: "4.square.fill")
                    Text("Fourth")
                        .tag(3)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }

            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .accentColor(.green) // Green color for icons
        //.background(Color(red: 0.7, green: 0.9, blue: 0.7).ignoresSafeArea()) // Custom background color
    }
}


struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .imageScale(.large)
                .foregroundColor(.green)
            Text("Profile Page")
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
        .padding()
        
    }
}

struct AboutView: View {
    var body: some View {
        VStack {
            Image(systemName: "info.circle")
                .imageScale(.large)
                .foregroundColor(.green)
            Text("About Us")
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
}

#Preview {
    ContentView()
}

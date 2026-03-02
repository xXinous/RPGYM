import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
            
            RoutinesListView()
                .tabItem {
                    Label("Rotinas", systemImage: "figure.walk")
                }
            
            WorkoutView()
                .tabItem {
                    Label("Treino", systemImage: "figure.strengthtraining.traditional")
                }
            
            CharacterView()
                .tabItem {
                    Label("Personagem", systemImage: "sword")
                }
        }
        .tint(Color.primary)
    }
}

#Preview {
    MainTabView()
}

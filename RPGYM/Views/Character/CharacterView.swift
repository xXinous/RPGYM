import SwiftUI

struct CharacterView: View {
    var body: some View {
        VStack {
            Image(systemName: "sword")
                .font(.largeTitle)
                .foregroundColor(.purple)
                .padding()
            Text("Gamificação V2")
                .font(.headline)
        }
    }
}

#Preview {
    CharacterView()
}

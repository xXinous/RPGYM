import SwiftUI

struct WorkoutView: View {
    var body: some View {
        VStack {
            Image(systemName: "wrench.and.screwdriver.fill")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .padding()
            Text("Treino em desenvolvimento")
                .font(.headline)
        }
    }
}

#Preview {
    WorkoutView()
}

import SwiftUI
import CoreData

struct RoutineDetailView: View {
    @ObservedObject var routine: Routine
    @ObservedObject var viewModel: RoutinesViewModel
    
    var routineExercises: [RoutineExercise] {
        let set = routine.exercises as? Set<RoutineExercise> ?? []
        return Array(set).sorted { $0.id.uuidString < $1.id.uuidString }
    }
    
    var body: some View {
        List {
            Section(header: Text("Exercícios")) {
                if routineExercises.isEmpty {
                    Text("Nenhum exercício nesta rotina.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(routineExercises, id: \.id) { re in
                        if let exercise = viewModel.getExercise(by: re.exerciseID) {
                            HStack {
                                Image(systemName: exercise.image)
                                    .foregroundColor(.appPrimary)
                                    .font(.title2)
                                    .frame(width: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(exercise.name).font(.headline)
                                    HStack {
                                        Text("\(re.sets) Séries x \(re.reps) Reps")
                                            .font(.subheadline)
                                        if re.weightKg > 0 {
                                            Text("• \(re.weightKg, specifier: "%.1f") kg")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(exercise.muscleGroups, id: \.self) { muscle in
                                                PillTag(text: muscle, color: muscleColor(for: muscle))
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        } else {
                            Text("Exercício desconhecido")
                        }
                    }
                }
            }
        }
        .navigationTitle(routine.name)
    }
    
    func muscleColor(for muscle: String) -> Color {
        switch muscle {
        case "Peito": return .muscleChest
        case "Pernas": return .muscleLegs
        case "Costas": return .blue
        case "Ombros": return .purple
        case "Tríceps", "Bíceps": return .orange
        case "Core": return .red
        default: return .gray
        }
    }
}

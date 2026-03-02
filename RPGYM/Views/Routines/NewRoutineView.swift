import SwiftUI

struct NewRoutineView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: RoutinesViewModel
    
    @State private var routineName: String = ""
    @State private var selectedExercises: [(exercise: Exercise, sets: Int, reps: Int, weight: Double)] = []
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Nome da Rotina", text: $routineName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List {
                    Section(header: Text("Adicionar Exercícios")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.filteredExercises, id: \.id) { exercise in
                                    Button(action: {
                                        addExercise(exercise)
                                    }) {
                                        VStack {
                                            Image(systemName: exercise.image)
                                                .font(.largeTitle)
                                                .foregroundColor(.appPrimary)
                                            Text(exercise.name)
                                                .font(.caption)
                                                .lineLimit(1)
                                        }
                                        .frame(width: 80, height: 80)
                                        .background(Color.customBackground)
                                        .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Exercícios Selecionados")) {
                        ForEach($selectedExercises.indices, id: \.self) { index in
                            VStack(alignment: .leading) {
                                Text(selectedExercises[index].exercise.name)
                                    .font(.headline)
                                
                                HStack {
                                    Stepper("Séries: \(selectedExercises[index].sets)", value: $selectedExercises[index].sets, in: 1...10)
                                    Spacer()
                                    Stepper("Reps: \(selectedExercises[index].reps)", value: $selectedExercises[index].reps, in: 1...50)
                                }
                                
                                HStack {
                                    Text("Peso (kg):")
                                    TextField("0.0", value: $selectedExercises[index].weight, formatter: NumberFormatter())
                                        .keyboardType(.decimalPad)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .frame(width: 80)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: removeExercise)
                        .onMove(perform: moveExercise)
                    }
                }
            }
            .navigationTitle("Nova Rotina")
            .navigationBarItems(
                leading: Button("Cancelar") { presentationMode.wrappedValue.dismiss() },
                trailing: Button("Salvar") {
                    viewModel.addRoutine(name: routineName, exercises: selectedExercises)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(routineName.isEmpty || selectedExercises.isEmpty)
            )
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        selectedExercises.append((exercise: exercise, sets: 3, reps: 10, weight: 0.0))
    }
    
    func removeExercise(at offsets: IndexSet) {
        selectedExercises.remove(atOffsets: offsets)
    }
    
    func moveExercise(from source: IndexSet, to destination: Int) {
        selectedExercises.move(fromOffsets: source, toOffset: destination)
    }
}

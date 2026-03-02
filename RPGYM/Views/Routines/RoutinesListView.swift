import SwiftUI

struct RoutinesListView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: RoutinesViewModel
    @State private var showingNewRoutine = false
    
    init() {
        _viewModel = StateObject(wrappedValue: RoutinesViewModel(context: CoreDataStack.shared.context))
    }
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.routines.isEmpty {
                    Text("Nenhuma rotina criada ainda. Toque no + para criar.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.routines, id: \.id) { routine in
                        NavigationLink(destination: RoutineDetailView(routine: routine, viewModel: viewModel)) {
                            VStack(alignment: .leading) {
                                Text(routine.name)
                                    .font(.headline)
                                Text("\(routine.exercises?.count ?? 0) exercícios")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: viewModel.deleteRoutine)
                }
            }
            .navigationTitle("Minhas Rotinas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewRoutine = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingNewRoutine) {
                NewRoutineView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.fetchRoutines()
            }
        }
    }
}

#Preview {
    RoutinesListView()
}

import SwiftUI

struct ProfileView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: ProfileViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(context: CoreDataStack.shared.context))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    TextField("Nome", text: $viewModel.name)
                    TextField("Idade", text: $viewModel.age)
                        .keyboardType(.numberPad)
                    TextField("Peso (kg)", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                    TextField("Altura (cm)", text: $viewModel.height)
                        .keyboardType(.numberPad)
                    Picker("Sexo", selection: $viewModel.sex) {
                        Text("Masculino").tag("Masculino")
                        Text("Feminino").tag("Feminino")
                        Text("Outro").tag("Outro")
                    }
                }
                
                Section {
                    CustomButton(title: "Salvar Alterações", icon: "square.and.arrow.down") {
                        viewModel.saveProfile {
                            // Saved
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Perfil")
            .onAppear {
                viewModel.loadProfile()
            }
        }
    }
}

#Preview {
    ProfileView()
}

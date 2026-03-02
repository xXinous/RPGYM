import SwiftUI

struct OnboardingView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject private var viewModel: ProfileViewModel
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    
    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(context: CoreDataStack.shared.context))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Básicas")) {
                    TextField("Nome", text: $viewModel.name)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red, lineWidth: viewModel.showError && viewModel.name.isEmpty ? 1 : 0)
                        )
                    
                    TextField("Idade", text: $viewModel.age)
                        .keyboardType(.numberPad)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red, lineWidth: viewModel.showError && viewModel.age.isEmpty ? 1 : 0)
                        )
                    
                    TextField("Peso (kg)", text: $viewModel.weight)
                        .keyboardType(.decimalPad)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red, lineWidth: viewModel.showError && viewModel.weight.isEmpty ? 1 : 0)
                        )
                    
                    TextField("Altura (cm)", text: $viewModel.height)
                        .keyboardType(.numberPad)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.red, lineWidth: viewModel.showError && viewModel.height.isEmpty ? 1 : 0)
                        )
                    
                    Picker("Sexo", selection: $viewModel.sex) {
                        Text("Masculino").tag("Masculino")
                        Text("Feminino").tag("Feminino")
                        Text("Outro").tag("Outro")
                    }
                }
                
                Section {
                    Button(action: viewModel.importFromHealth) {
                        HStack {
                            Image(systemName: "heart.fill")
                            Text("Importar do Saúde (Mock)")
                        }
                    }
                    .foregroundColor(.appPrimary)
                }
                
                Section {
                    CustomButton(title: "Salvar e Continuar", icon: "checkmark") {
                        viewModel.saveProfile {
                            hasCompletedOnboarding = true
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Bem-vindo ao RPGYM")
        }
    }
}

#Preview {
    OnboardingView()
}

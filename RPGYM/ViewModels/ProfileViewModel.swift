import Foundation
import CoreData
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var sex: String = "Masculino"
    
    @Published var showError: Bool = false
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        loadProfile()
    }
    
    func importFromHealth() {
        // Mock import
        name = "João Atleta"
        age = "28"
        weight = "75.5"
        height = "180"
        sex = "Masculino"
    }
    
    var isValid: Bool {
        !name.isEmpty && !age.isEmpty && !weight.isEmpty && !height.isEmpty
    }
    
    func saveProfile(completion: () -> Void) {
        guard isValid else {
            showError = true
            return
        }
        
        // Fetch or create
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        let results = try? context.fetch(request)
        let profile = results?.first ?? UserProfile(context: context)
        
        profile.name = name
        profile.age = Int16(age) ?? 0
        profile.weightKg = Double(weight) ?? 0.0
        profile.heightCm = Double(height) ?? 0.0
        profile.sex = sex
        profile.createdAt = profile.createdAt == Date.distantPast ? Date() : profile.createdAt
        
        CoreDataStack.shared.save()
        completion()
    }
    
    func loadProfile() {
        let request: NSFetchRequest<UserProfile> = UserProfile.fetchRequest()
        if let profile = try? context.fetch(request).first {
            name = profile.name
            age = "\(profile.age)"
            weight = "\(profile.weightKg)"
            height = "\(profile.heightCm)"
            sex = profile.sex
        }
    }
}

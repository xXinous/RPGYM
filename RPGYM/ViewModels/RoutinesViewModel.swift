import Foundation
import CoreData
import SwiftUI

class RoutinesViewModel: ObservableObject {
    @Published var availableExercises: [Exercise] = []
    @Published var routines: [Routine] = []
    @Published var searchText: String = ""
    
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        loadExercises()
        fetchRoutines()
    }
    
    func loadExercises() {
        guard let url = Bundle.main.url(forResource: "ExercisesData", withExtension: "json") else {
            print("Failed to find ExercisesData.json in bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Exercise].self, from: data)
            self.availableExercises = decoded
        } catch {
            print("Error decoding exercises: \(error)")
        }
    }
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return availableExercises
        }
        return availableExercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    func fetchRoutines() {
        let request: NSFetchRequest<Routine> = Routine.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Routine.createdAt, ascending: false)]
        
        do {
            routines = try context.fetch(request)
        } catch {
            print("Error fetching routines: \(error)")
        }
    }
    
    func addRoutine(name: String, exercises: [(exercise: Exercise, sets: Int, reps: Int, weight: Double)]) {
        let routine = Routine(context: context)
        routine.id = UUID()
        routine.name = name
        routine.createdAt = Date()
        
        for item in exercises {
            let re = RoutineExercise(context: context)
            re.id = UUID()
            re.exerciseID = item.exercise.id
            re.sets = Int16(item.sets)
            re.reps = Int16(item.reps)
            re.weightKg = item.weight
            re.durationSeconds = 0
            routine.addToExercises(re)
        }
        
        CoreDataStack.shared.save()
        fetchRoutines()
    }
    
    func deleteRoutine(at offsets: IndexSet) {
        for index in offsets {
            let routine = routines[index]
            context.delete(routine)
        }
        CoreDataStack.shared.save()
        fetchRoutines()
    }
    
    func getExercise(by id: UUID) -> Exercise? {
        availableExercises.first { $0.id == id }
    }
}

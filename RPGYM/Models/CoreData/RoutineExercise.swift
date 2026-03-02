import Foundation
import CoreData

@objc(RoutineExercise)
public class RoutineExercise: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var exerciseID: UUID
    @NSManaged public var sets: Int16
    @NSManaged public var reps: Int16
    @NSManaged public var weightKg: Double
    @NSManaged public var durationSeconds: Int32
    
    // Relationship back to Routine
    @NSManaged public var routine: Routine?
}

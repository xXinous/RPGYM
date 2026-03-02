import Foundation
import CoreData

@objc(Routine)
public class Routine: NSManagedObject {
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var createdAt: Date
    @NSManaged public var exercises: NSSet?
}

// MARK: Generated accessors for exercises
extension Routine {
    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: RoutineExercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: RoutineExercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)
}

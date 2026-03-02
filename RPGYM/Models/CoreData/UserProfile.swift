import Foundation
import CoreData

@objc(UserProfile)
public class UserProfile: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var weightKg: Double
    @NSManaged public var heightCm: Double
    @NSManaged public var sex: String
    @NSManaged public var createdAt: Date
}

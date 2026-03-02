import SwiftUI

@main
struct RPGYMApp: App {
    let coreDataStack = CoreDataStack.shared
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
                    .environment(\.managedObjectContext, coreDataStack.context)
            } else {
                OnboardingView()
                    .environment(\.managedObjectContext, coreDataStack.context)
            }
        }
    }
}

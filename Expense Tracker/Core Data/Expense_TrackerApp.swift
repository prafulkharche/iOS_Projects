

internal import SwiftUI
internal import CoreData

@main
struct ExpenseTrackerApp: App {
    let persistence = PersistenceController.shared

    init() {
        CategorySeeder.seedIfNeeded(
            context: persistence.container.viewContext
        )
        print(NSHomeDirectory())
    }

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext,
                              persistence.container.viewContext)
        }
    }
}


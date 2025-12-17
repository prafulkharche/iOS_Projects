

import Foundation
internal import CoreData

struct CategorySeeder {

    static func seedIfNeeded(context: NSManagedObjectContext) {

        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let count = (try? context.count(for: request)) ?? 0

        guard count == 0 else { return }

        let names = AppConstants.ExpenseCategories

        for name in names {
            let category = Category(context: context)
            category.id = UUID()
            category.name = name
        }

        try? context.save()
    }
}

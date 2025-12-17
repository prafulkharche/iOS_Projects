

import Foundation
internal import CoreData 
internal import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []

    private let context = PersistenceController.shared.container.viewContext

    func fetchCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        categories = (try? context.fetch(request)) ?? []
    }

    func addCategory(name: String) {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }

        let category = Category(context: context)
        category.id = UUID()
        category.name = name

        try? context.save()
        fetchCategories()
    }
}

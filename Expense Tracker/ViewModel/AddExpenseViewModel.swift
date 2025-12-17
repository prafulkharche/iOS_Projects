

import Foundation
internal import SwiftUI
internal import Combine
internal import CoreData



final class AddExpenseViewModel: ObservableObject {

    @Published var amount = ""
    @Published var note = ""
    @Published var selectedCategory: Category?
    @Published var categories: [Category] = []
    @Published var errorMessage: String?

    private let context = PersistenceController.shared.container.viewContext

    func fetchCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true)
        ]

        categories = (try? context.fetch(request)) ?? []

        // Auto-select first
        if selectedCategory == nil {
            selectedCategory = categories.first
        }
    }

    func save() -> Bool {
        guard let value = Double(amount), value > 0 else {
            errorMessage = AppConstants.amountErrorMsg
            return false
        }

        guard let category = selectedCategory else {
            errorMessage = AppConstants.categoryErrorMsg
            return false
        }

        let expense = Expense(context: context)
        expense.id = UUID()
        expense.amount = value
        expense.note = note
        expense.date = Date()
        expense.category = category

        do {
            try context.save()
            return true
        } catch {
            errorMessage = AppConstants.saveErrorMsg
            return false
        }
    }
}

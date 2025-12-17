internal import CoreData
internal import Combine

internal import SwiftUI


class ExpenseListViewModel: ObservableObject {
    @Published var expenses: [Expense] = []

    // Delete Alert control
    @Published var showDeleteAlert = false
    var expenseToDelete: Expense?

    private let context = PersistenceController.shared.container.viewContext

    func fetchExpenses() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]
        expenses = (try? context.fetch(request)) ?? []
    }

    // Called from swipe
    func requestDelete(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        expenseToDelete = expenses[index]
        showDeleteAlert = true
    }

    // Actual delete
    func confirmDelete() {
        guard let expense = expenseToDelete else { return }

        context.delete(expense)
        try? context.save()

        expenseToDelete = nil
        showDeleteAlert = false
        fetchExpenses()
    }
    
    var totalAmount: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

}


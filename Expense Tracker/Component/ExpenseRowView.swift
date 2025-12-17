internal import SwiftUI


struct ExpenseRowView: View {
    let expense: Expense

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.category?.name ?? "")
                    .font(.headline)
                    .foregroundStyle(Color(.cyan))
                Text(expense.note ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("\(AppConstants.currencySymbol)\(expense.amount, specifier: AppConstants.amountSpecifier)")
                .font(.headline)
                .foregroundStyle(Color(.red))
        }
    }
}


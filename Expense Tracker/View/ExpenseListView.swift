


internal import SwiftUI



struct ExpenseListView: View {
    @StateObject private var vm = ExpenseListViewModel()
    @State private var showAdd = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {

                // Total Expense Header
                VStack(spacing: 4) {
                    Text(AppConstants.totalExpense)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("\(AppConstants.currencySymbol)\(vm.totalAmount, specifier: AppConstants.amountSpecifier)")
                        .font(.largeTitle.bold())
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.systemGroupedBackground))

                // Expense List
                List {
                    ForEach(vm.expenses) { expense in
                        ExpenseRowView(expense: expense)
                    }
                    .onDelete(perform: vm.requestDelete)
                }
            }
            .navigationTitle(AppConstants.navTitle)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAdd, onDismiss: vm.fetchExpenses) {
                AddExpenseView()
            }
            
            // Delete Confirmation Alert
            .alert(
                AppConstants.deleteAlertTitle,
                isPresented: $vm.showDeleteAlert
            ) {
                Button(AppConstants.deleteButtonTitle, role: .destructive) {
                    vm.confirmDelete()
                }
                Button(AppConstants.cancelButtonTitle, role: .cancel) { }
            } message: {
                Text(AppConstants.deleteMsg)
            }
            .onAppear {
                vm.fetchExpenses()
            }
        }
    }
}

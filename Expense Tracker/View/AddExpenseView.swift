internal import SwiftUI

struct AddExpenseView: View {
    @StateObject private var vm = AddExpenseViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {

                // Amount field
                TextField(AppConstants.amount, text: $vm.amount)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                
                // Note field
                TextField(AppConstants.note, text: $vm.note)
                    .textFieldStyle(.roundedBorder)

                // Category dropdown
                Menu {
                    ForEach(vm.categories) { category in
                        Button {
                            vm.selectedCategory = category
                        } label: {
                            Text(category.name ?? "")
                        }
                    }
                } label: {
                    HStack {
                        Text(vm.selectedCategory?.name ?? AppConstants.category)
                            .foregroundColor(
                                vm.selectedCategory == nil ? .gray : .primary
                            )
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(.gray)
                    }
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5))
                    )
                }

                

                // Error message
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                // Save button
                Button(AppConstants.saveExpense) {
                    if vm.save() {
                        dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle(AppConstants.addExpensNavTitle)
            .onAppear {
                vm.fetchCategories()
            }
        }
    }
}



import Foundation
internal import SwiftUI


struct AppConstants {
    
   //MARK: - View Constants

    //Login Screen Related Constants
    static let title: String = "Expense Tracker"
    static let usernamePlaceholder: String = "Username"
    static let passwordPlaceholder: String = "Password"
    static let login: String = "Login"
    static let forgotPassword: String = "Forgot Password?"
    
    //Expense List Related Constants
    static let currencySymbol: String = "₹"
    static let totalExpense: String = "Total Expenses"
    static let navTitle: String = "Expenses"
    static let amountSpecifier: String = "%.2f"
    
    //AddExpense Related Constants
    static let amount: String = "Amount"
    static let category: String = "Category"
    static let note: String = "Note"
    static let saveExpense: String = "Save Expense"
    static let addExpensNavTitle: String = "Add Expense"
    
    
    
    //MARK: ViewModels Constants
    
    // Login ViewModel Constants
    static let emailErrorMsg : String = "Email and password cannot be empty"
    static let invalidEmailErrorMsg : String = "Please enter a valid email"
    static let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let predicateFormat: String = "SELF MATCHES %@"
    
    
    // AddExpense ViewModel
    static let amountErrorMsg: String = "Amount must be greater than 0"
    static let categoryErrorMsg: String = "Please select a category"
    static let saveErrorMsg: String = "Save failed"
    
    
    
    //MARK: Model Constants
    static let ExpenseCategories: [String] = [
        "Food",
        "Transport",
        "Shopping",
        "Bills",
        "Entertainment",
        "Health",
        "Other"
    ]
    
    
    
    // Delete msges
    static let deleteAlertTitle: String =  "Delete Expense?"
    static let deleteMsg: String = "This action cannot be undone."
    static let deleteButtonTitle: String = "Delete"
    static let cancelButtonTitle: String = "Cancel"
}

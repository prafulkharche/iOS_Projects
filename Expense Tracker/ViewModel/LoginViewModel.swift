internal import SwiftUI
internal import Combine



final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoggedIn = false
    @Published var errorMessage: String? = nil

    func login() {
        // Clear previous error
        errorMessage = nil
        
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = AppConstants.emailErrorMsg
            return
        }
        
        guard isValidEmail(email) else {
            errorMessage = AppConstants.invalidEmailErrorMsg
            return
        }
        
        // Mock login success
        isLoggedIn = true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Regex for email validation
        let emailRegEx = AppConstants.emailRegex
        let predicate = NSPredicate(format:AppConstants.predicateFormat, emailRegEx)
        return predicate.evaluate(with: email)
    }
}


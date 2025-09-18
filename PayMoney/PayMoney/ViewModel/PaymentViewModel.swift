import Foundation



class PaymentViewModel {
    
    var recipientName = "" { didSet { validateRecipientName() } }
    var accountNumber = "" { didSet { validateAccountNumber() } }
    var amount = "" { didSet { validateAmount() } }
    var iban = "" { didSet { validateIBAN() } }
    var swiftCode = "" { didSet { validateSwiftCode() } }
    var paymentType: PaymentType = .domestic { didSet { paymentTypeChanged?(paymentType); validateAll() } }
    
    // Closures to update UI
    var recipientNameError: ((String?) -> Void)?
    var accountNumberError: ((String?) -> Void)?
    var amountError: ((String?) -> Void)?
    var ibanError: ((String?) -> Void)?
    var swiftCodeError: ((String?) -> Void)?
    
    var isSendEnabled: ((Bool) -> Void)?
    var paymentTypeChanged: ((PaymentType) -> Void)?
    var onPaymentSuccess: (() -> Void)?
    
    // MARK: - Validation
    private func validateRecipientName() {
        let error = recipientName.isEmpty ? "Recipient name required" : nil
        recipientNameError?(error)
        validateAll()
    }
    
    private func validateAccountNumber() {
        let error = accountNumber.isEmpty ? "Account number required" : nil
        accountNumberError?(error)
        validateAll()
    }
    
    private func validateAmount() {
        let error = amount.isEmpty ? "Amount required" : nil
        amountError?(error)
        validateAll()
    }
    
    private func validateIBAN() {
        guard paymentType == .international else { return }
        let error = iban.count == 34 ? nil : "IBAN must be 34 characters"
        ibanError?(error)
        validateAll()
    }
    
    private func validateSwiftCode() {
        guard paymentType == .international else { return }
        let regex = #"^[A-Z]{4}-[A-Z]{2}-[A-Z]{2}-\d{2}$"#
        let valid = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: swiftCode)
        let error = valid ? nil : "Invalid SWIFT format"
        swiftCodeError?(error)
        validateAll()
    }
    
    func validateAll() {
        var valid = !recipientName.isEmpty && !accountNumber.isEmpty && !amount.isEmpty
        if paymentType == .international {
            valid = valid && iban.count == 34
            let regex = #"^[A-Z]{4}-[A-Z]{2}-[A-Z]{2}-\d{2}$"#
            valid = valid && NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: swiftCode)
        }
        isSendEnabled?(valid)
    }
    
    // MARK: - Actions
    func sendPayment() {
        if isSendEnabled != nil {
            onPaymentSuccess?()
            clearFields()
        }
    }
    
    func clearFields() {
        recipientName = ""
        accountNumber = ""
        amount = ""
        iban = ""
        swiftCode = ""
        validateAll()
    }
    
    
    
}


//
//  AppDelegate.swift
//  PayMoney


import UIKit

class PaymentViewController: UIViewController {
    
    // MARK: - ViewModel
    let viewModel = PaymentViewModel()
    
    // MARK: - UI Components
    let paymentTypeLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textColor = .systemBlue
        lbl.textAlignment = .center
        lbl.text = "Payment Type: Domestic"
        return lbl
    }()
    
    let recipientNameField = CustomTextField()
    let accountNumberField = CustomTextField()
    let amountField = CustomTextField()
    let ibanField = CustomTextField()
    let swiftCodeField = CustomTextField()
    
    let countryField = CustomTextField()
    let countryPicker = UIPickerView()
    let countries = ["USA", "India", "UK", "Canada", "Australia"] 
    
    let sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Send Payment", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.alpha = 0.5
        btn.isEnabled = false
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupBindings()
        setupActions()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        // Country Picker
        countryField.setTitle("Country")
        countryField.setPlaceholder("Select country")
        countryField.textField.inputView = countryPicker
        countryPicker.dataSource = self
        countryPicker.delegate = self
        
        // Other fields
        recipientNameField.setTitle("Recipient Name")
        recipientNameField.setPlaceholder("Enter name")
        accountNumberField.setTitle("Account Number")
        accountNumberField.setPlaceholder("Enter account")
        accountNumberField.textField.keyboardType = .numberPad
        
        amountField.setTitle("Amount ($)")
        amountField.setPlaceholder("Enter amount")
        amountField.textField.keyboardType = .decimalPad
        
        ibanField.setTitle("IBAN")
        ibanField.setPlaceholder("Enter IBAN (34 chars)")
        swiftCodeField.setTitle("SWIFT Code")
        swiftCodeField.setPlaceholder("Enter SWIFT (AAAA-BB-CC-12)")
        
        // Stack
        let stack = UIStackView(arrangedSubviews: [
            paymentTypeLabel,
            countryField,
            recipientNameField,
            accountNumberField,
            amountField,
            ibanField,
            swiftCodeField,
            sendButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        updateUIForPaymentType()
    }
    
    
    // MARK: - Bindings
    func setupBindings() {
        viewModel.recipientNameError = { [weak self] error in
            error != nil ? self?.recipientNameField.showError(error!) : self?.recipientNameField.hideError()
        }
        viewModel.accountNumberError = { [weak self] error in
            error != nil ? self?.accountNumberField.showError(error!) : self?.accountNumberField.hideError()
        }
        viewModel.amountError = { [weak self] error in
            error != nil ? self?.amountField.showError(error!) : self?.amountField.hideError()
        }
        viewModel.ibanError = { [weak self] error in
            error != nil ? self?.ibanField.showError(error!) : self?.ibanField.hideError()
        }
        viewModel.swiftCodeError = { [weak self] error in
            error != nil ? self?.swiftCodeField.showError(error!) : self?.swiftCodeField.hideError()
        }
        
        viewModel.isSendEnabled = { [weak self] enabled in
            self?.sendButton.isEnabled = enabled
            self?.sendButton.alpha = enabled ? 1 : 0.5
        }
        
        viewModel.onPaymentSuccess = { [weak self] in
            self?.recipientNameField.textField.text = ""
            self?.accountNumberField.textField.text = ""
            self?.amountField.textField.text = ""
            self?.ibanField.textField.text = ""
            self?.swiftCodeField.textField.text = ""
            self?.countryField.textField.text = ""
            
            
            self?.showSuccessBanner(message: "✅ Payment Sent Successfully!")
        }
    }
    
    // MARK: - Actions
    func setupActions() {
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        recipientNameField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        accountNumberField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        amountField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        ibanField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        swiftCodeField.textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc func textChanged() {
        viewModel.recipientName = recipientNameField.textField.text ?? ""
        viewModel.accountNumber = accountNumberField.textField.text ?? ""
        viewModel.amount = amountField.textField.text ?? ""
        viewModel.iban = ibanField.textField.text ?? ""
        viewModel.swiftCode = swiftCodeField.textField.text ?? ""
        viewModel.validateAll()
    }
    
    @objc func sendTapped() {
        viewModel.sendPayment()
    }
    
    
    private func showSuccessBanner(message: String) {
        let banner = UILabel()
        banner.text = message
        banner.textAlignment = .center
        banner.backgroundColor = UIColor.systemGreen
        banner.textColor = .white
        banner.font = UIFont.boldSystemFont(ofSize: 16)
        banner.alpha = 0
        banner.layer.cornerRadius = 8
        banner.layer.masksToBounds = true
        banner.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(banner)
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            banner.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        UIView.animate(withDuration: 0.5, animations: {
            banner.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 2.0, options: [], animations: {
                banner.alpha = 0
            }) { _ in
                banner.removeFromSuperview()
            }
        }
    }
    
    
    
    
    // MARK: - UI Update
    func updateUIForPaymentType() {
        let showInternational = viewModel.paymentType == .international
        ibanField.isHidden = !showInternational
        swiftCodeField.isHidden = !showInternational
        paymentTypeLabel.text = "Payment Type: " + (showInternational ? "International" : "Domestic")
    }
}

// MARK: - UIPickerView
extension PaymentViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { countries.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countries[row]
        countryField.textField.text = country
        countryField.textField.resignFirstResponder()
        
        // Determine payment type
        viewModel.paymentType = (country == "USA") ? .domestic : .international
        
        updateUIForPaymentType()
        viewModel.validateAll()
    }
}

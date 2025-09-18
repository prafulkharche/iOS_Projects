import UIKit

class CustomTextField: UIView {
    
    // MARK: - UI Components
    private let topLabel = UILabel()
    let textField = UITextField()
    private let bottomLabel = UILabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Setup
    private func setupUI() {
        // Top Label
        topLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        topLabel.textColor = .darkGray
        
        // TextField
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 8
        textField.font = UIFont.systemFont(ofSize: 16)
        
        // Bottom Label
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        bottomLabel.textColor = .red
        bottomLabel.numberOfLines = 0
        bottomLabel.isHidden = true
        
        // Stack Layout
        let stack = UIStackView(arrangedSubviews: [topLabel, textField, bottomLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Functions
    func setTitle(_ title: String) {
        topLabel.text = title
    }
    
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func showError(_ message: String) {
        bottomLabel.text = message
        bottomLabel.isHidden = false
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideError() {
        bottomLabel.isHidden = true
        bottomLabel.text = nil
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
}

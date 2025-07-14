//
//  ViewController.swift
//  Core Data Demo Using Swift
//
//  Created by Apple on 08/07/25.
//

import UIKit

class ViewController: UIViewController {

    

        let nameTF = UITextField()
        let addressTF = UITextField()
        let empIDTF = UITextField()
        let mobileTF = UITextField()
        let gradeTF = UITextField()
        let saveButton = UIButton(type: .system)
        let showButton = UIButton(type: .system)


        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white

            setupFields()
            pageTitle()
        }

        func setupFields() {
            let stack = UIStackView(arrangedSubviews: [nameTF, addressTF, empIDTF, mobileTF, gradeTF, saveButton, showButton])
            stack.axis = .vertical
            stack.spacing = 12
            stack.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(stack)

            NSLayoutConstraint.activate([
                stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                
            ])

            [nameTF, addressTF, empIDTF, mobileTF, gradeTF].forEach {
                $0.borderStyle = .roundedRect
                $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            }

            nameTF.placeholder = "Name"
            addressTF.placeholder = "Address"
            empIDTF.placeholder = "Emp ID"
            mobileTF.placeholder = "Mobile"
            gradeTF.placeholder = "Grade"

            saveButton.setTitle("Save", for: .normal)
            saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
            saveButton.tintColor = .black
            saveButton.backgroundColor = .white
            saveButton.layer.cornerRadius = 10.0
           

            showButton.setTitle("Show All", for: .normal)
            showButton.addTarget(self, action: #selector(showTapped), for: .touchUpInside)
            showButton.tintColor = .black
            showButton.backgroundColor = .white
            showButton.layer.cornerRadius = 10.0
        }
    
    func pageTitle(){
        let PageTitle = UILabel()
        PageTitle.text = "Employee Data"
        PageTitle.font = UIFont.boldSystemFont(ofSize: 26)
        PageTitle.textColor = .white
        PageTitle.textAlignment = .center
        PageTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(PageTitle)
        
        NSLayoutConstraint.activate([
            PageTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            PageTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PageTitle.heightAnchor.constraint(equalToConstant: 30),
            PageTitle.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc func saveTapped() {
       
        guard let name = nameTF.text, !name.isEmpty,
                  let address = addressTF.text, !address.isEmpty,
                  let empID = empIDTF.text, !empID.isEmpty,
                  let mobile = mobileTF.text, !mobile.isEmpty,
                  let grade = gradeTF.text, !grade.isEmpty else {
                // Show alert or error
            AlertManager.Shared.showAlert(on: self, message: "Check the entered data")
                return
            }

            CoreDataManager.shared.saveEmployee(
                name: name,
                address: address,
                empID: empID,
                mobile: mobile,
                grade: grade
            )
            clearFields()
        AlertManager.Shared.showSuccessAlert(on: self, message: "Saved Data Successfully")
        
    }

        @objc func showTapped() {
            let listVC = EmployeeListViewController()
            navigationController?.pushViewController(listVC, animated: true)
        }

        func clearFields() {
            [nameTF, addressTF, empIDTF, mobileTF, gradeTF].forEach { $0.text = "" }
        }
    }

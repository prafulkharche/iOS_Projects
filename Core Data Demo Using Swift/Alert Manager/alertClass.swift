//
//  alertClass.swift
//  Core Data Demo Using Swift
//
//  Created by Apple on 08/07/25.
//

import Foundation
import UIKit
import Foundation

class AlertManager {
    
    static let Shared = AlertManager()
    
    private init(){}
    
    func showAlert(on viewController: UIViewController, message: String) {
            let alert = UIAlertController(title: "Missing Info", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }

    func showSuccessAlert(on viewController: UIViewController, message: String) {
            let alert = UIAlertController(title: "Suceess", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController.present(alert, animated: true)
        }
    
}

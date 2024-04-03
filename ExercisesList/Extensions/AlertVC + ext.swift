//
//  AlertVC + ext.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import UIKit
extension UIViewController{
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}

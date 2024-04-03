//
//  AlertVC.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//


import UIKit
import SnapKit

final class AlertVC: UIViewController {
    
    private let containerView = AlertContainer()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    
    private let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubview(containerView)
        view.addSubview(titleLabel)
        view.addSubview(actionButton)
        view.addSubview(messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    private func configLabel(label: UILabel, sizeText: CGFloat, weithText: UIFont.Weight, lines: Int, alignment: NSTextAlignment, color: UIColor){
        label.textAlignment = alignment
        label.textColor = color
        label.numberOfLines = lines
        label.font = .systemFont(ofSize: sizeText, weight: weithText)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true // Enable font size adjustment
        label.minimumScaleFactor = 0.9 // Set the minimum scale factor
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
     private func configureContainerView() {
         containerView.snp.makeConstraints { make in
             make.centerX.centerY.equalToSuperview()
             make.height.equalTo(200)
             make.width.equalTo(180)
         }
    }
    
    private func configureTitleLabel(){
        configLabel(label: titleLabel, sizeText: 18, weithText: .bold, lines: 1, alignment: .center, color: .black)
        titleLabel.text = alertTitle
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(28)
        }
    }
    
    private func configureActionButton(){
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.layer.cornerRadius = 16
        actionButton.backgroundColor = .lightGray
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.height.equalTo(44)
        }
    }
    
    private func configureMessageLabel(){
        configLabel(label: messageLabel, sizeText: 14, weithText: .regular, lines: 0, alignment: .center, color: .black)
        messageLabel.text = message
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.bottom.equalTo(actionButton.snp.top).offset(-6)
            
        }
    }
    
    @objc private func dismissVC(){
        dismiss(animated: true)
    }
}

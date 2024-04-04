//
//  DetailViewController.swift
//  ExercisesList
//
//  Created by Polina on 04.04.2024.
//

import UIKit
import SnapKit
class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol!
    
    private let buttonToAnotherFlow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Go to Another Flow", for: .normal)
        button.layer.cornerRadius = 16
        
        return button
    }()
    
    @objc private func  tappedButton(){
        presenter.goToAnotherFlow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstrains()
        buttonToAnotherFlow.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        view.backgroundColor = .red
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol{
    
}


// MARK: - SetUpConstrains
private extension DetailViewController{
    func setUpConstrains(){
        view.addSubview(buttonToAnotherFlow)
        buttonToAnotherFlow.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(8)
            make.height.equalTo(70)
        }
    }
 
}

//
//  HeaderView.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//


import UIKit

class HeaderView: UICollectionReusableView {
    static let resuseID = "HeaderView"
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews(){
        backgroundColor = .none
    }
    
    private func setViews(){
        [
            headerLabel,
        ].forEach { addSubview($0) }
    }
    
    private func layoutViews(){
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configureHeader(sectionTitle: String){
        headerLabel.text = sectionTitle
    }
}

//
//  typeCell.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//


import UIKit
import SnapKit

class TypeCell: UICollectionViewCell {
    static let resuseID = "TypeCell"
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: ConstColors.greenDark)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .bold)
        //label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var backImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.backgroundColor = UIColor(named: ConstColors.orangeLight)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        typeLabel.text = nil
    }
    
    private func setViews(){
        contentView.addSubview(backImage)
        contentView.addSubview(typeLabel)
    }
    
    private func layoutViews(){
        typeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing)
        }
        
        backImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(typeLabel.snp.leading).offset(-4)
            make.trailing.equalTo(typeLabel.snp.trailing).offset(4)
        }
//        backImage.snp.makeConstraints { make in
//            make.edges.equalTo(contentView)
//        }
//        typeLabel.snp.makeConstraints { make in
//            make.centerX.equalTo(contentView.snp.centerX)
//            make.centerY.equalTo(contentView.snp.centerY)
//        }
    }
}

//MARK: - Configure Cell UI Public Method
extension TypeCell{
    func configCell(typeLabelText: String){
        typeLabel.text = typeLabelText
    }
    
//    func setSelectedColors(){
//        typeLabel.textColor = UIColor(named: ConstColors.yellowLight)
//        backImage.backgroundColor = UIColor(named: ConstColors.greenLight)
//    }
//    
//    func setDefaultColors(){
//        typeLabel.textColor = UIColor(named: ConstColors.greenDark)
//        backImage.backgroundColor = UIColor(named: ConstColors.orangeLight)
//    }
}

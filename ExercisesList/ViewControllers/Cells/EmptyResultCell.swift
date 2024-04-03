//
//  EmptyResultCell.swift
//  ExercisesList
//
//  Created by Polina on 03.04.2024.
//

import UIKit
import SnapKit

class EmptyResultCell: UICollectionViewCell {
    static let resuseID = "EmptyResultCell"
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: ConstColors.greenDark)
        label.numberOfLines = 0
        label.text = "Choose params for your workout!"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.9
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyStateImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "emptyView"))
        image.layer.cornerRadius = 32
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var backImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 16
        image.backgroundColor = UIColor(named: ConstColors.greenLight)
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
    }
    
    private func setViews(){
        contentView.addSubview(backImage)
        contentView.addSubview(typeLabel)
        contentView.addSubview(emptyStateImageView)
    }
    
    private func layoutViews(){
        emptyStateImageView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(150)
        }
        
        backImage.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyStateImageView.snp.bottom).offset(12)
            make.centerX.equalTo(contentView.snp.centerX)
            make.leading.greaterThanOrEqualTo(backImage.snp.leading).offset(4)
            make.trailing.lessThanOrEqualTo(backImage.snp.trailing).offset(-4)
        }
    }
}



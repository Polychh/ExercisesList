//
//  ResultExercisesCell.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//


import UIKit

final class ResultExercisesCell: UICollectionViewCell {
    static let resuseID = "ResultExercisesCell"
    
    
    private let exercisesNameLabel = UILabel()
    private let typeExerciseslabel = UILabel()
    private let muscleLabel = UILabel()
    private let equipmentLabel = UILabel()
    private let difficultyLabel = UILabel()
    private let instructionLabel = UILabel()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ConstColors.greenDark)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowColor = UIColor(named: ConstColors.greenLight)?.cgColor
        view.layer.cornerRadius = 15
        view.clipsToBounds = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUIElements()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUIElements(){
        configLabel(label: exercisesNameLabel, sizeText: 18, weithText: .bold, lines: 2, alignment: .center, color: .white)
        configLabel(label: typeExerciseslabel, sizeText: 16, weithText: .semibold, lines: 2, alignment: .center, color: .white)
        configLabel(label: muscleLabel, sizeText: 16, weithText: .semibold, lines: 2, alignment: .center, color: .white)
        configLabel(label: equipmentLabel, sizeText: 16, weithText: .semibold, lines: 2, alignment: .center, color: .white)
        configLabel(label: difficultyLabel, sizeText: 16, weithText: .semibold, lines: 2, alignment: .center, color: .white)
        configLabel(label: instructionLabel, sizeText: 14, weithText: .medium, lines: 0, alignment: .left, color: .white)

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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        exercisesNameLabel.text = nil
        typeExerciseslabel.text = nil
        muscleLabel.text = nil
        equipmentLabel.text = nil
        difficultyLabel.text = nil
        instructionLabel.text = nil
    }
}

//MARK: - Configure Cell UI
extension ResultExercisesCell{
    func configCell(nameExercises: String, typeExercises: String, muscleType: String, equipment: String, difficulty: String, instruction: String){
        exercisesNameLabel.text = nameExercises
        muscleLabel.text = muscleType
        typeExerciseslabel.text = typeExercises
        equipmentLabel.text = equipment
        difficultyLabel.text = difficulty
        instructionLabel.text = instruction
    }
}

//MARK: - Constrains
extension ResultExercisesCell{
    private func setConstrains(){
        [
            backView,
            exercisesNameLabel,
            typeExerciseslabel,
            muscleLabel,
            difficultyLabel,
            equipmentLabel,
            instructionLabel
            
        ].forEach{ contentView.addSubview($0)}
        
        backView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        exercisesNameLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp.top).offset(6)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
        }
        
        typeExerciseslabel.snp.makeConstraints { make in
            make.top.equalTo(exercisesNameLabel.snp.bottom).offset(5)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
        }
        
        muscleLabel.snp.makeConstraints { make in
            make.top.equalTo(typeExerciseslabel.snp.bottom).offset(5)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
        }
        
        difficultyLabel.snp.makeConstraints { make in
            make.top.equalTo(muscleLabel.snp.bottom).offset(5)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
        }
        
        equipmentLabel.snp.makeConstraints { make in
            make.top.equalTo(difficultyLabel.snp.bottom).offset(5)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
        }
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(equipmentLabel.snp.bottom).offset(5)
            make.leading.equalTo(backView.snp.leading).offset(6)
            make.trailing.equalTo(backView.snp.trailing).offset(-6)
            make.bottom.equalTo(backView.snp.bottom).offset(-5)
        }
    }
}

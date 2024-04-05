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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let buttonToAnotherFlow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: ConstColors.yellowLight)
        button.setTitle("Go to Another Flow", for: .normal)
        button.setTitleColor(UIColor(named: ConstColors.greenDark), for: .normal)
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstrains()
        configUIElements()
        configureCollectionView()
        configNavigationControllerAppearence()
    }
}

// MARK: - ConfigVC
private extension DetailViewController{
    func configureCollectionView(){
        collectionView.backgroundColor = .none
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ResultExercisesCell.self, forCellWithReuseIdentifier: ResultExercisesCell.resuseID)
    }
    
    func configNavigationControllerAppearence(){
        navigationItem.title = "Results"
        navigationController?.navigationBar.tintColor = UIColor(named: ConstColors.greenDark)
        if let navigationController = navigationController {
            navigationController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),
                NSAttributedString.Key.foregroundColor: UIColor(named: ConstColors.greenDark) ?? .black
            ]
        }
    }
    
    func configUIElements(){
        buttonToAnotherFlow.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc func  tappedButton(){
        presenter.goToAnotherFlow()
    }
}

// MARK: - DetailViewProtocol
extension DetailViewController: DetailViewProtocol{
    func reloadData() {
        collectionView.reloadData()
    }
}

//MARK: -  UICollectionViewDataSource
extension DetailViewController:  UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.dataSerachWord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultExercisesCell.resuseID, for: indexPath) as? ResultExercisesCell else { return UICollectionViewCell() }
        let data = presenter.dataSerachWord[indexPath.row]
        cell.configCell(nameExercises: data.name, typeExercises: data.type, muscleType: data.muscle, equipment: data.equipment, difficulty: data.difficulty, instruction: data.instructions)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 // from left and right of the screen
        let availableWidth = view.bounds.width - (padding * 2)
        let widthPerItem = availableWidth
        return CGSize(width: widthPerItem, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}


// MARK: - SetUpConstrains
private extension DetailViewController{
    func setUpConstrains(){
        view.backgroundColor = .white
        view.addSubview(buttonToAnotherFlow)
        view.addSubview(collectionView)
        buttonToAnotherFlow.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(8)
            make.height.equalTo(70)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(buttonToAnotherFlow.snp.top).offset(-16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
    }
}

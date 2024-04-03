//
//  ViewController.swift
//  ExercisesList
//
//  Created by Polina on 02.04.2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var presenter: MainPresenterProtocol!
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: ConstColors.greenDark) ?? .black, renderingMode: .alwaysOriginal)
        let clearImage = UIImage(systemName: "xmark.circle.fill")?.withTintColor(UIColor(named: ConstColors.greenDark) ?? .black, renderingMode: .alwaysOriginal)
        search.setImage(image, for: .search, state: .normal)
        search.setImage(clearImage, for: .clear, state: .normal)
        search.delegate = self
        search.barTintColor = nil
        search.searchTextField.font = .systemFont(ofSize: 18, weight: .bold)
        search.tintColor = UIColor(named: ConstColors.greenDark) ?? .black
        search.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        search.searchTextField.placeholder = "Search"
        search.searchTextField.textColor = UIColor(named: ConstColors.greenDark) ?? .black
        search.searchTextField.backgroundColor = UIColor(named: ConstColors.yellowLight)
        search.translatesAutoresizingMaskIntoConstraints = false
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: ConstColors.greenDark) ?? .black])
        search.searchTextField.attributedPlaceholder = attributedPlaceholder
        return search
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstrains()
        configureCollectionView()
        setupAppearenceSeacrhBar()
        
    }
}
// MARK: - Config UI Elements
private extension MainViewController{
    func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(TypeCell.self, forCellWithReuseIdentifier: TypeCell.resuseID)
        //        collectionView.register(CoctailCell.self, forCellWithReuseIdentifier: CoctailCell.resuseID)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.resuseID)
    }
    
  func setupAppearenceSeacrhBar(){
      let backgroundImage = UIImage.imageWithColor(color: .white)
        searchBar.setBackgroundImage(backgroundImage, for: .any, barMetrics: .default)
        searchBar.layer.cornerRadius = 12.0
        searchBar.clipsToBounds = true
    }
}
// MARK: - MainViewProtocol
extension MainViewController: MainViewProtocol{
    
}

//MARK: - Create CollectionViewLayput
private extension MainViewController{
    private func createLayout() -> UICollectionViewCompositionalLayout{
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self else { return nil }
            let section = presenter.dataSections[sectionIndex]
            
            switch section{
            case .exercisesType:
                return createTypeSectionLayout()
            case .muscleType:
                return createTypeDifficultySectionLayout()
            case .difficulty:
                return createTypeDifficultySectionLayout()
            case .resultExercises:
                return createTypeDifficultySectionLayout()
            }
        }
    }
    
    private func createTypeSectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width:  .fractionalWidth(0.6), height: .fractionalHeight(0.1), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .continuous, groupSpacing: 8, leading: 16, trailing: 16, top: 4, bottom: 4, supplementary: [createHeader()])
        return section
    }
    
    private func createTypeDifficultySectionLayout() -> NSCollectionLayoutSection{
        let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 0)
        let group = CompositionalLayout.createGroup(alignment: .horizontal, width: .estimated(110), height: .estimated(40), subitems: [item])
        let section = CompositionalLayout.createSection(group: group, scrollBehavior: .continuous, groupSpacing: 8, leading: 16, trailing: 16, top: 4, bottom: 4, supplementary: [createHeader()])
        return section
    }
    
    //    private func createCoctailDataSectionLayout() -> NSCollectionLayoutSection{
    //        let item = CompositionLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1), spacing: 5)
    //        let group = CompositionLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.2), subitems: [item])
    //        let section = CompositionLayout.createSection(group: group, scrollBehavior: .none, groupSpacing: 0, leading: 10, trailing: 10, supplementary: [createHeader()])
    //        return section
    //    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem{
        .init(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}
// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.dataSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = presenter.dataSections[section]
        switch sections{
        case .exercisesType:
            return presenter.exetcisesType.count
        case .muscleType:
            return presenter.muscleType.count
        case .difficulty:
            return presenter.difficultyType.count
        case .resultExercises:
            return presenter.difficultyType.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = presenter.dataSections[indexPath.section]
        switch sections{
        case .exercisesType:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.resuseID, for: indexPath) as? TypeCell else { return UICollectionViewCell()}
            let data = presenter.exetcisesType[indexPath.item]
            cell.configCell(typeLabelText: data.typeLabel)
            return cell
        case .muscleType:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.resuseID, for: indexPath) as? TypeCell else { return UICollectionViewCell()}
            let data = presenter.muscleType[indexPath.item]
            cell.configCell(typeLabelText: data.muscleLabel)
            return cell
        case .difficulty:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.resuseID, for: indexPath) as? TypeCell else { return UICollectionViewCell()}
            let data = presenter.difficultyType[indexPath.item]
            cell.configCell(typeLabelText: data.difficultyLabel)
            return cell
        case .resultExercises:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeCell.resuseID, for: indexPath) as? TypeCell else { return UICollectionViewCell()}
            let data = presenter.difficultyType[indexPath.item]
            cell.configCell(typeLabelText: data.difficultyLabel)
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.resuseID, for: indexPath) as? HeaderView else { return UICollectionReusableView()}
            header.configureHeader(sectionTitle: presenter.dataSections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}
// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate{
    
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        print(searchText)
        searchBar.resignFirstResponder()
    }
}

// MARK: - SetConstrains
private extension MainViewController{
    func setConstrains(){
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(view.snp.top).offset(64)
            make.height.equalTo(70)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
 
}


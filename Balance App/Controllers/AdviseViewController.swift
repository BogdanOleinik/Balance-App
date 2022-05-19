//
//  AdviseViewController.swift
//  Balance App
//
//  Created by Олейник Богдан on 18.05.2022.
//

import UIKit

struct Advise: Hashable, Decodable {
    var adviseName: String
    var adviseDescription: String
    var adviseImage: String
    var id: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Advise, rhs: Advise) -> Bool {
        return lhs.id == rhs.id
    }
}

class AdviseViewController: UIViewController {
    
    let data = Bundle.main.decode([Advise].self, from: "data.json")
    let data1 = Bundle.main.decode([Advise].self, from: "data1.json")
    let data2 = Bundle.main.decode([Advise].self, from: "data2.json")
    
    enum Section: Int, CaseIterable {
        case health, richessOfLife, spiritualGrows
        
        func description() -> String {
            switch self {
            case .health:
                return "Health and energy"
            case .richessOfLife:
                return "Richess of life"
            case .spiritualGrows:
                return "Spiritual growth"
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Advise>?
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        createDataSource()
        reloadData()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .backgroundColor()
        view.addSubview(collectionView)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        
        collectionView.register(HealthCell.self, forCellWithReuseIdentifier: HealthCell.reuseId)
        collectionView.register(RichnessOfLifeCell.self, forCellWithReuseIdentifier: RichnessOfLifeCell.reuseId)
        collectionView.register(SpiritualGrowthCell.self, forCellWithReuseIdentifier: SpiritualGrowthCell.reuseId)
        
        collectionView.delegate = self
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Advise>()
        snapShot.appendSections([.health, .richessOfLife, .spiritualGrows])
        snapShot.appendItems(data, toSection: .health)
        snapShot.appendItems(data1, toSection: .richessOfLife)
        snapShot.appendItems(data2, toSection: .spiritualGrows)
        dataSource?.apply(snapShot, animatingDifferences: true)
    }
}

// MARK: - Data Source
extension AdviseViewController {
    
    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with value: Advise, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
        cell.configure(with: value)
        return cell
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Advise>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, advise) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknow section kind")
            }
            
            switch section {
            case .health:
                return self.configure(cellType: HealthCell.self, with: advise, for: indexPath)
            case .richessOfLife:
                return self.configure(cellType: RichnessOfLifeCell.self, with: advise, for: indexPath)
            case .spiritualGrows:
                return self.configure(cellType: SpiritualGrowthCell.self, with: advise, for: indexPath)
            }
        })
        
        dataSource?.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else { fatalError("Can not create new section") }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configure(
                text: section.description(),
                font: .avenir18(),
                textColor: .firstTextColor()
            )
            return sectionHeader
        }
    }
}

// MARK: - Setup layout
extension AdviseViewController {
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            guard let section = Section(rawValue: sectionIndex) else {
                fatalError("Unknow section kind")
            }
            
            switch section {
            case .health:
                return self.createSection()
            case .richessOfLife:
                return self.createSection()
            case .spiritualGrows:
                return self.createSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
    
    private func createSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(180))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 20, bottom: 0, trailing: 20)
        
        let sectionHeader = createSectionHeader()
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)

        return sectionHeader
    }
}

// MARK: - UICollectionViewDelegate
extension AdviseViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let advise = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        let vc = DescriptionAdviseViewController(advise: advise)
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - SwiftUI
import SwiftUI

struct AdviseVC: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBar = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<AdviseVC.ContainerView>) -> MainTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController: AdviseVC.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<AdviseVC.ContainerView>) {
            
        }
    }
}
    
//
//    enum Section: Int, CaseIterable {
//        case health
//    }
//    
//    var dataSource: UICollectionViewDiffableDataSource<Section, Advise>?
//    var collectionView: UICollectionView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        setupCollectionView()
//        createDataSource()
//        reloadData()
//    }
//    
//    private func setupCollectionView() {
//        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.backgroundColor = .backgroundColor()
//        view.addSubview(collectionView)
//
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
//        
//    }
//    
//    private func createDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<Section, Advise>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, advise) -> UICollectionViewCell? in
//            guard let section = Section(rawValue: indexPath.section) else {
//                fatalError("Unknow section kind")
//            }
//            
//            switch section {
//            case .health:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
//                cell.backgroundColor = .systemBlue
//                return cell
//            }
//        })
//    }
//    
//    private func reloadData() {
//        var snapShot = NSDiffableDataSourceSnapshot<Section, Advise>()
//        snapShot.appendSections([.health])
//        snapShot.appendItems(advise, toSection: .health)
//        dataSource?.apply(snapShot, animatingDifferences: true)
//    }
//
//    private func createCompositionalLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
//            
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                  heightDimension: .fractionalHeight(1))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            group.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 8, trailing: 0)
//            
//            let section = NSCollectionLayoutSection(group: group)
//            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
//            return section
//        }
//        return layout
//    }
//}

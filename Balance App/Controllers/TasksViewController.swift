//
//  ViewController.swift
//  Balance App
//
//  Created by Олейник Богдан on 16.05.2022.
//

import UIKit

class TasksViewController: UIViewController {
    
    let data = Bundle.main.decode([Advise].self, from: "data.json")
    
    enum Section: Int, CaseIterable {
        case health
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

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellid")
        
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Advise>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, advise) -> UICollectionViewCell? in
            guard let section = Section(rawValue: indexPath.section) else {
                fatalError("Unknow section kind")
            }
            
            switch section {
            case .health:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath)
                cell.backgroundColor = .systemBlue
                return cell
            }
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Advise>()
        snapShot.appendSections([.health])
        snapShot.appendItems(data, toSection: .health)
        dataSource?.apply(snapShot, animatingDifferences: true)
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(84))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
            return section
        }
        return layout
    }
}


// MARK: - SwiftUI
import SwiftUI

struct TasksVC: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBar = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<TasksVC.ContainerView>) -> MainTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController: TasksVC.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<TasksVC.ContainerView>) {
            
        }
    }
}

//    let segmenterdControl: UISegmentedControl = {
//        let segmentedControl = UISegmentedControl(items: ["Health", "Spirit", "Career", "Life"])
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
//        return segmentedControl
//    }()
//
//    lazy var rowsToDisplay = data
//
//    let data = ["sdf", "sdf", "grs"]
//    let elseData = ["ytj", "sv", "y4"]
//
//    let tableView = UITableView(frame: .zero, style: .plain)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.dataSource = self
//        tableView.delegate = self
//
//        view.backgroundColor = .white
//        navigationItem.title = "Advise"
//
//        let paddedStackView = UIStackView(arrangedSubviews: [segmenterdControl])
//        paddedStackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
//        paddedStackView.isLayoutMarginsRelativeArrangement = true
//
//        let stackView = UIStackView(arrangedSubviews: [
//            paddedStackView, tableView
//            ])
//        stackView.axis = .vertical
//
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//
//    }
//
//    @objc fileprivate func handleSegmentChange() {
//
//        switch segmenterdControl.selectedSegmentIndex {
//        case 0:
//            rowsToDisplay = data
//        case 1:
//            rowsToDisplay = elseData
//        case 2:
//            rowsToDisplay = data
//        default:
//            rowsToDisplay = elseData
//        }
//
//        tableView.reloadData()
//    }
//}
//
//extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        rowsToDisplay.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()
//        let data = rowsToDisplay[indexPath.row]
//        var content = cell.defaultContentConfiguration()
//        content.text = data
//        cell.contentConfiguration = content
//
//        return cell
//    }
//}

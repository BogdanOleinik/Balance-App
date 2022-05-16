//
//  ViewController.swift
//  Balance App
//
//  Created by Олейник Богдан on 16.05.2022.
//

import UIKit

class AdviseViewController: UIViewController {
    
    let segmenterdControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Health", "Spirit", "Career", "Life"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var rowsToDisplay = data
    
    let data = ["sdf", "sdf", "grs"]
    let elseData = ["ytj", "sv", "y4"]
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .white
        navigationItem.title = "Advise"
        
        let paddedStackView = UIStackView(arrangedSubviews: [segmenterdControl])
        paddedStackView.layoutMargins = .init(top: 10, left: 10, bottom: 10, right: 10)
        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [
            paddedStackView, tableView
            ])
        stackView.axis = .vertical
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
            
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc fileprivate func handleSegmentChange() {
        
        switch segmenterdControl.selectedSegmentIndex {
        case 0:
            rowsToDisplay = data
        case 1:
            rowsToDisplay = elseData
        case 2:
            rowsToDisplay = data
        default:
            rowsToDisplay = elseData
        }
        
        tableView.reloadData()
    }
}

extension AdviseViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsToDisplay.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = rowsToDisplay[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = data
        cell.contentConfiguration = content

        return cell
    }
}

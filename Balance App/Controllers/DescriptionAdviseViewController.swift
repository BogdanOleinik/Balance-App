//
//  DescriptionAdviseViewController.swift
//  Balance App
//
//  Created by Олейник Богдан on 19.05.2022.
//

import UIKit

class DescriptionAdviseViewController: UIViewController {

    let nameLabel = UILabel(text: "Name Label", font: .avenir18(), textColor: .firstTextColor())
    let descriptionLabel = UILabel(text: "Description Label", font: .avenir16(), textColor: .secondTextColor())
    
    private let advise: Advise

    init(advise: Advise) {
        self.advise = advise
        self.nameLabel.text = advise.adviseName
        self.descriptionLabel.text = advise.adviseDescription
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        setupConstraints()
    }
    
    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
        ])
    }
}

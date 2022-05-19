//
//  SpiritualGrowthCell.swift
//  Balance App
//
//  Created by Олейник Богдан on 19.05.2022.
//

import UIKit

class SpiritualGrowthCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId = "SpiritualGrowthCell"
    
    let adviseImageView = UIImageView()
    let adviseName = UILabel(text: "SpiritualGrowth", font: .avenir16(), textColor: #colorLiteral(red: 0.09019607843, green: 0.1176470588, blue: 0.1725490196, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func configure(with value: Advise) {
        adviseImageView.image = UIImage(named: value.adviseImage)
        adviseName.text = value.adviseName
    }
    
    private func setupConstraints() {
        adviseImageView.translatesAutoresizingMaskIntoConstraints = false
        adviseName.translatesAutoresizingMaskIntoConstraints = false
        
        adviseImageView.backgroundColor = .systemMint
//        adviseName.backgroundColor = .systemBlue
        
        addSubview(adviseImageView)
        addSubview(adviseName)
        
        NSLayoutConstraint.activate([
            adviseImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            adviseImageView.topAnchor.constraint(equalTo: self.topAnchor),
            adviseImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            adviseImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            adviseName.leadingAnchor.constraint(equalTo: adviseImageView.leadingAnchor, constant: 10),
            adviseName.trailingAnchor.constraint(equalTo: adviseImageView.trailingAnchor, constant: -10),
            adviseName.bottomAnchor.constraint(equalTo: adviseImageView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SwiftUI
import SwiftUI

struct SpiritualGrowthProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let tabBar = MainTabBarController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SpiritualGrowthProvider.ContainerView>) -> MainTabBarController {
            return tabBar
        }
        
        func updateUIViewController(_ uiViewController: SpiritualGrowthProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SpiritualGrowthProvider.ContainerView>) {
            
        }
    }
}

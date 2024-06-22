//
//  FlashCardsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/8/24.
//

import UIKit

class FlashCardSetViewController: UIViewController {
    
    let viewmodel:FlashcardSetViewModel
    
    init(viewmodel: FlashcardSetViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(112))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            //let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
           // let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
           // header.pinToVisibleBounds = true  // This makes the header sticky
            //section.boundarySupplementaryItems = [header]
            return section
        }
        
        
    }()
//    lazy var label:UILabel = {
//       let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        label.text = "flashcard set"
//        label.backgroundColor = UIColor.systemBlue
//        
//        
//        
//        return label
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(label)
        setupConstraints()

        // Do any additional setup after loading the view.
    }
    
    


}

extension FlashCardSetViewController{
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
}

extension FlashCardSetViewController{
    
//    @objc
//    private func addNewFlashCard(){
//        navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
//    }
    
}

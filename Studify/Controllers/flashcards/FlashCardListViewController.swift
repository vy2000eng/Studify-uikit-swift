//
//  FlashCardListViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit

class FlashCardListViewController: UIViewController{
    let viewmodel: FlashcardSetViewModel
    
    init(viewmodel: FlashcardSetViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout {  sectionIndex, enviroment in
            return self.flashcardSet()
        }
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        v.register(FlashCardListCollectionViewCell.self, forCellWithReuseIdentifier: "listCell")
       // v.register(FlashCardSetCollectionViewCell.self, forCellWithReuseIdentifier: "smallSetCell")
        
        v.isScrollEnabled = true
        v.delegate = self
        v.dataSource = self
        return v
        
        
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       
        

        // Do any additional setup after loading the view.
    }

}

extension FlashCardListViewController{
    
    private func setup(){
        view.addSubview(collectionView)
        setupConstraints()
        
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    
    
    
}

extension FlashCardListViewController{
    
    func flashcardSet() -> NSCollectionLayoutSection{
        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
//        let fcSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
//        let fc2 = NSCollectionLayoutItem(layoutSize: fcSize2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))

        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fc])
        let section = NSCollectionLayoutSection(group: group)

        return section
        
        
    }
}



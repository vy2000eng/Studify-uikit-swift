//
//  FlashCardsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/8/24.
//

import UIKit
//        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(112))
//            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            let section = NSCollectionLayoutSection(group: group)
//            //let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
//           // let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
//           // header.pinToVisibleBounds = true  // This makes the header sticky
//            //section.boundarySupplementaryItems = [header]
//            section.orthogonalScrollingBehavior = .paging
//            return section
//        }

final class FlashCardSetViewController: UIViewController {
    
    let viewmodel:FlashcardSetViewModel
    
    //MARK: init
    init(viewmodel: FlashcardSetViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout {  sectionIndex, enviroment in
            
           return  sectionIndex == 0 ?  self.flashcardSet() : self.smallFlashcardSet()
        }
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        v.register(FlashCardSetCollectionViewCell.self, forCellWithReuseIdentifier: "setCell")
        v.register(FlashCardSetCollectionViewCell.self, forCellWithReuseIdentifier: "smallSetCell")
        
        v.isScrollEnabled = false
        v.delegate = self
        v.dataSource = self
        return v
        
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewmodel.getAllFlashcards()
        
        for flashcard in viewmodel.flashcards{
            print("front: \(flashcard.front)")
            print("front: \(flashcard.back)")
            
        }
        setupView()
    }
}

extension FlashCardSetViewController{
    
    private func setupView(){
        view.addSubview(collectionView)
        setupConstraints()
        setupCloseButton()
        setupAddButton()

        
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

extension FlashCardSetViewController{
    func flashcardSet() -> NSCollectionLayoutSection{
        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fc])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        return section
    }
    func smallFlashcardSet() -> NSCollectionLayoutSection{
        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fc])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    

}


extension FlashCardSetViewController{
 
    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeViewController))
    }

    private func setupAddButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewFlashCard))
    }
    
    @objc
    private func addNewFlashCard(){
        let vc = AddNewFlashCardViewController(topicID:viewmodel.topicID)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func closeViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}

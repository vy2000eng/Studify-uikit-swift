//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import UIKit

class FlashCardGameViewController: UIViewController {
    
    let viewmodel:FlashcardSetViewModel
    
    init(viewmodel: FlashcardSetViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout {  sectionIndex, enviroment in
            return  self.flashcardSet()
        }
        
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.backgroundColor = .clear
        v.translatesAutoresizingMaskIntoConstraints = false
        
        v.register(FlashCardGameCollectionViewCell.self, forCellWithReuseIdentifier: "setCell")
       // v.register(FlashCardSetCollectionViewCell.self, forCellWithReuseIdentifier: "smallSetCell")
       // v.register(FlashcardSmallSetViewControllerHeader.self,  forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
        //let longPress = UILongPressGestureRecognizer(target: self, action: #selector( handleLongPress(gesture:)))
       // v.addGestureRecognizer(longPress)
        v.isScrollEnabled = false
        v.delegate = self
        v.dataSource = self
        return v
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .clear
         setup()
        // Do any additional setup after loading the view.
    }
    


}

extension FlashCardGameViewController{
    private func setup(){
        view.addSubview(collectionView)
//        label.text = "game controller"
//        view.addSubview(label)
//        label.backgroundColor = .blue
        
        setupConstraints()
        
    }
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        
        ])
        
    }
}

extension FlashCardGameViewController{
    func flashcardSet() -> NSCollectionLayoutSection{
        
        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(400))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fc])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        return section
    }
}

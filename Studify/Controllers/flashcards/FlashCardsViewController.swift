//
//  FlashCardsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/8/24.
//

import UIKit

protocol FlashCardSetViewControllerDelegate:AnyObject{
    /*MARK: This protocol is specifically for updating the number of flashcards when we pop the flashcardcardTabViewController.
            It is called inside of closeViewController.
     */
    func didUpdateNumberOfFlashcards(indexPath: IndexPath)
}
final class FlashCardSetViewController: UIViewController, AddNewFlashCardViewControllerDelegate {
  
    
    weak var delegate: FlashCardSetViewControllerDelegate?
    
    let viewmodel:FlashcardSetViewModel
    
    let topicIndexPath: IndexPath
    
    //MARK: init
    init(viewmodel: FlashcardSetViewModel, topicIndexPath: IndexPath){
        self.viewmodel = viewmodel
        self.topicIndexPath = topicIndexPath
        
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
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func closeViewController() {
        delegate?.didUpdateNumberOfFlashcards(indexPath: topicIndexPath)
        dismiss(animated: true, completion: nil)
    }
    
    func didAddFlashcard() {
        print("didAddFlashcardCalled")
        updateFlashCard()

    }
    func updateFlashCard(){
        print("updateFlashcard called")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
        
        DispatchQueue.main.async {
             self.collectionView.performBatchUpdates({
                 self.collectionView.insertItems(at: [indexPathSetCell, indexPathSmallSetCell])

             }, completion: { finished in
                 if finished {
                     self.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                    self.collectionView.scrollToItem(at: indexPathSmallSetCell, at: .centeredHorizontally, animated: true)
             
                 }
             })
         }
            
    }
    
}

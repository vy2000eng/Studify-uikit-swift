//
//  FlashCardListViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/20/24.
//

import UIKit


protocol FlashCardListViewControllerDelegate: AnyObject{
    func didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: IndexPath)

}

protocol UpdateFlashCardInSetViewControllerDelegate: AnyObject{
    func updateFlashCardInSetViewControllerFromListViewController()
}



class FlashCardListViewController: UIViewController, AddNewFlashCardToListViewControllerDelegate{
    
  
    let viewmodel: FlashcardSetViewModel
    let topicIndexPath: IndexPath
    weak var delegate: FlashCardListViewControllerDelegate?
    weak var updateFlashCardInSetViewControllerDelegate: UpdateFlashCardInSetViewControllerDelegate?
    
    
    init(viewmodel: FlashcardSetViewModel,topicIndexPath: IndexPath) {
        self.viewmodel = viewmodel
        self.topicIndexPath = topicIndexPath
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
        v.isScrollEnabled = true
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("list view loaded")
        setupAddButton()
        setupCloseButton()
        

        setup()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewAppeared")

        viewmodel.getAllFlashcards()
        for flashcard in viewmodel.flashcards{
            print("front: \(flashcard.front)")
            print("front: \(flashcard.back)")
            
        }
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fc])
       
        let section = NSCollectionLayoutSection(group: group)
        return section
        
        
    }
}

extension FlashCardListViewController{
    private func setupAddButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewFlashCard))
    }
    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeViewController))
    }

    @objc
    private func addNewFlashCard(){
        let vc = AddNewFlashCardViewController(flashcardSetViewModel: viewmodel, whichControllerPushed: 1)
        vc.flashCardListViewControllerDelegate = self
       // viewmodel.flashCardSetViewControllerDelegate = self
        //vc.delegate = self
        //viewmodel.flashCardListViewControllerDelegate = self
       // viewmodel.flashCardSetViewControllerDelegate = self

        navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    private func closeViewController() {
        delegate?.didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: topicIndexPath)
        dismiss(animated: true, completion: nil)
    }
    
    func didAddFlashcardToList() {
        print("updateFlashcard called in list vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        
        //let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
        // self.flashcardListViewController.collectionView.reloadData()
        
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [indexPathSetCell])
                
            }
                                                                                ,completion: { finished in
                if finished {
                    self.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: true)
                    
                }
            }
            )
        }
        updateFlashCardInSetViewControllerDelegate?.updateFlashCardInSetViewControllerFromListViewController()
   
        
    }
    
    
//    func didAddFlashcard() {
//        print("didAddFlashcardCalled in list vc")
//
//        updateFlashCard()
//    }
//    
//    func updateFlashCard(){
//        print("updateFlashcard called in list vc")
//        viewmodel.getAllFlashcards()
//        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
//        //let indexPathSmallSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 1)
//        
//        DispatchQueue.main.async {
//             self.collectionView.performBatchUpdates({
//                 self.collectionView.insertItems(at: [indexPathSetCell])
//
//             }, completion: { finished in
//                 if finished {
//                     self.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: true)
//             
//                 }
//             })
//         }
//            
//    }
}



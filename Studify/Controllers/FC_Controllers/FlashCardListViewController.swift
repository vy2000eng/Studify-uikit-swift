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

// MARK: EXPLANATION of UpdateFlashCardInSetViewControllerDelegate:
// This is important for updating the collectionView inside of FlashCardSetViewController
// Meaning this class is NOT THE  FlashCardSetViewController.
// THIS IS CLASS IS IN FACT THE FlashCardListViewController!
protocol AddFlashCardToSetViewCollectionDelegate: AnyObject{
    // MARK: updateFlashCardInSetViewControllerFromListViewController()
    // "updateFlashCardInSetViewControllerFromListViewController()" is called right after updates are made to the UI inside of "didAddFlashcardToList()"
    // The delegate i.e. "updateFlashCardInSetViewControllerDelegate" is set inside of "FlashCardTabViewController"
    // "updateFlashCardInSetViewControllerDelegate" is set inside of "FlashCardTabViewController" because "FlashCardTabViewController" has access to both "FlashCardSetViewController" and "FlashCardListViewController"
    // "updateFlashCardInSetViewControllerFromListViewController()" updates the collectionView inside of "FlashCardListViewController" so that they are the same
    func didAddFlashCardToSetViewControllerFromListViewController()
}

protocol UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate:AnyObject{
    func didUpdateFlashCardInSetViewControllerFromListViewController(indexPath:IndexPath)
    func didDeleteFlashCardInSetViewControllerFromListViewController(indexPath:IndexPath)
}

class FlashCardListViewController: UIViewController, AddNewFlashCardToListViewControllerDelegate, UpdateFlashCardInListViewControllerDelegate{
    
  
    let viewmodel: FlashcardSetViewModel
    let topicIndexPath: IndexPath
    weak var delegate: FlashCardListViewControllerDelegate?
    weak var addFlashCardInSetViewControllerDelegate: AddFlashCardToSetViewCollectionDelegate?
    weak var updateFlashCardInSetViewControllerDelegate: UpdateFlashCardInFlashCardSetViewControllerCollectionViewDelegate?
    
    
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
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector( handleLongPress(gesture:)))
        v.addGestureRecognizer(longPress)

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
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: self.collectionView)
            if let indexPath = self.collectionView.indexPathForItem(at: point) {
                print("Long pressed item at \(indexPath.row)")
                let flashcard = viewmodel.flashcard(by: indexPath.row)
                let vc = EditFlashCardViewController(flashCardViewModel: flashcard,whichControllerPresented: 1,indexPath: indexPath)
                vc.flashcardListViewControllerDelegate = self
                present(vc,animated:true)
            }
        }
    }
    
    
    
    @objc
    private func addNewFlashCard(){
        let vc = AddNewFlashCardViewController(flashcardSetViewModel: viewmodel, whichControllerPushed: 1)
        // MARK: This delegate is for adding a flashcard to only the collection view defined in this viewcontroller.
        // The protocol for this delegate is defined in AddNewFlashCardViewController.
        // That is a fact. I know it might seem obvious, but I hope this help future you.
        // MARK: "flashCardListViewControllerDelegate" is defined in "AddNewFlashCardViewController"
        vc.flashCardListViewControllerDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    private func closeViewController() {
        delegate?.didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: topicIndexPath)
        dismiss(animated: true, completion: nil)
    }
    // MARK: As you may notice this function is not being called in this file.
    // MARK: That is because it is part of a protocol defined inside of "AddNewFlashCardViewController"
    
    func didAddFlashcardToList() {
        
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.numberOfFlashCards-1, section: 0)
        self.viewmodel.currentIndex = indexPathSetCell.row
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [indexPathSetCell])
            },completion: { finished in
                if finished {
                    self.collectionView.scrollToItem(at: indexPathSetCell, at: .bottom, animated: true)
                }
            })
        }
        
        //MARK: Tada what did I say!?
        //MARK: I said: " "updateFlashCardInSetViewControllerFromListViewController()" is called right after updates are made to the UI inside of "didAddFlashcardToList()" "
        //MARK: if you dont get it read the comment at the top of this file: "MARK: updateFlashCardInSetViewControllerFromListViewController()".
        addFlashCardInSetViewControllerDelegate?.didAddFlashCardToSetViewControllerFromListViewController()
    }
    
    
    func didUpdateFlashCardInList(indexPath: IndexPath) {
      
        viewmodel.getAllFlashcards()
        let indexPathListCell = IndexPath(row: indexPath.row, section: 0)
        self.viewmodel.currentIndex = indexPathListCell.row
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [indexPathListCell])
            } ,completion: { finished in
                if finished {
                    self.collectionView.scrollToItem(at: indexPathListCell, at: .bottom, animated: true)
                }
            })
        }
        updateFlashCardInSetViewControllerDelegate?.didUpdateFlashCardInSetViewControllerFromListViewController(indexPath: indexPath)
    }
    
    func didDeleteFlashCardInList(indexPath: IndexPath) {
        
        viewmodel.getAllFlashcards()
        let indexPathListCell = IndexPath(row: indexPath.row, section: 0)
        self.viewmodel.currentIndex = indexPath.row == 0 ? 0 : max(0, indexPath.row - 1)
                
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: [indexPathListCell])
            }, completion: { finished in
                if finished {
                    // Scroll to the new current index if needed
                    if self.viewmodel.numberOfFlashCards > 0 {
                        let newIndexPath = IndexPath(row: self.viewmodel.currentIndex, section: 0)
                        self.collectionView.scrollToItem(at: newIndexPath, at: .top, animated: true)
                    }
                }
            })
        }
        updateFlashCardInSetViewControllerDelegate?.didDeleteFlashCardInSetViewControllerFromListViewController(indexPath: indexPath)
    }
}



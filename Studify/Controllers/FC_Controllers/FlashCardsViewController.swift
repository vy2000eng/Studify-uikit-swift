//
//  FlashCardsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/8/24.
//

import UIKit

//MARK: This protocol is specifically for updating the number of flashcards when we pop the flashcardcardTabViewController.
//        It is called inside of closeViewController.

protocol FlashCardSetViewControllerDelegate:AnyObject{
    func didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: IndexPath)
}

protocol AddFlashCardToListViewCollectionDelegate: AnyObject{
    func didAddFlashCardInListViewControllerFromSetViewController()
}

protocol UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate:AnyObject{
    func didUpdateFlashCardInListViewControllerFromSetViewController(indexPath: IndexPath)
    func didDeleteFlashCardInListViewControllerFromSetViewController(indexPath:IndexPath, newIndexPathForList: IndexPath)
}

final class FlashCardSetViewController: UIViewController, AddNewFlashCardToSetViewControllerDelegate, UpdateFlashCardInSetViewControllerDelegate {

    weak var delegate: FlashCardSetViewControllerDelegate?
    weak var addFlashCardInListViewControllerDelegate: AddFlashCardToListViewCollectionDelegate?
    weak var updateFlashCardInListViewControllerDelegate: UpdateFlashCardInFlashCardListViewControllerCollectionViewDelegate?
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
        v.register(FlashcardSmallSetViewControllerHeader.self,  forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector( handleLongPress(gesture:)))
        v.addGestureRecognizer(longPress)
        v.isScrollEnabled = false
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()

        print("set view loaded")
        setupView()
    }
    
}

extension FlashCardSetViewController{
    
    private func setupView(){
        view.addSubview(collectionView)
        setupConstraints()
        setupCloseButton()
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()

       // setupAddButton()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 65),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fc])
        let section = NSCollectionLayoutSection(group: group)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment:.top)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [header]

        

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

//    private func setupAddButton(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .compose,
//            target: self,
//            action: #selector(addNewFlashCard))
//    }
    
    func createOptionsBarButtonItem() -> UIBarButtonItem{
        let addFlashCardAction = UIAction(title: "add flashcard"){ _ in
            let vc = AddNewFlashCardViewController(flashcardSetViewModel: self.viewmodel, whichControllerPushed: 0)
            // MARK: This delegate is for adding a flashcard to only the collection view defined in this viewcontroller.
            // The protocol for this delegate is defined in AddNewFlashCardViewController.
            // That is a fact. I know it might seem obvious, but I hope this help future you.
            // MARK: "flashCardListViewControllerDelegate" is defined in "AddNewFlashCardViewController"
            vc.flashCardSetViewControllerDelegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }
        let filterLearnedAction = UIAction(title: "learned flashcards"){ _ in
            
        }
        
        let filterUnlearnedAction = UIAction(title: "unlearned flashcards"){ _ in
            
        }
        
        let filterAllAction = UIAction(title: "all flashcards"){ _ in
            
        }

        let menu = UIMenu(title: "options", children: [addFlashCardAction, filterLearnedAction, filterUnlearnedAction, filterAllAction])
        
        return UIBarButtonItem(image: UIImage(systemName: "ellipsis"), menu: menu)
        
        
    }

    
    @objc
    private func addNewFlashCard(){
        let vc = AddNewFlashCardViewController(flashcardSetViewModel: viewmodel, whichControllerPushed: 0)
        vc.flashCardSetViewControllerDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func closeViewController() {
        delegate?.didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: topicIndexPath)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let point = gesture.location(in: self.collectionView)
            if let indexPath = self.collectionView.indexPathForItem(at: point) {
               // if indexPath.section == 1{
                    print("Long pressed item at \(indexPath.row)")
                    let flashcard = viewmodel.flashcard(by: indexPath.row)
                    
                    let vc = EditFlashCardViewController(flashCardViewModel: flashcard,whichControllerPresented: 0,indexPath: indexPath)
                    vc.flashcardSetViewControllerDelegate = self
                    
                    present(vc,animated:true)
                //}
            }
        }
    }
}

//MARK: - delegate functions
extension FlashCardSetViewController{
    
    func didAddFlashcardToSet() {
       
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 0)
        let indexPathSmallSetCell = IndexPath(row: viewmodel.flashcards.count-1, section: 1)
        self.viewmodel.currentIndex = indexPathSetCell.row

        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.viewmodel.isSectionCollapsed() ?
                self.collectionView.insertItems(at: [indexPathSetCell,indexPathSmallSetCell]) :
                self.collectionView.insertItems(at: [indexPathSetCell])


            } ,completion: {finished in
                if finished{
                 
                    self.collectionView.scrollToItem(at: indexPathSetCell, at: .right, animated: true)


                }
            })
        }
        addFlashCardInListViewControllerDelegate?.didAddFlashCardInListViewControllerFromSetViewController()
    }
    
    func didUpdateFlashCardInSet(indexPath: IndexPath) {
       print("did update in set called")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        self.viewmodel.currentIndex = indexPath.row
        

        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.viewmodel.isSectionCollapsed() ?
                self.collectionView.reconfigureItems(at: [indexPathSetCell, indexPathSmallSetCell]):
                self.collectionView.reconfigureItems(at: [indexPathSetCell])

                
            } ,completion: { finished  in
                if finished{
                    self.configureScrollBehavior(indexPath: indexPath, updateDelete: 1)

                }
            })
        }
        updateFlashCardInListViewControllerDelegate?.didUpdateFlashCardInListViewControllerFromSetViewController(indexPath: indexPath)
    }
    
    func didDeleteFlashCardInSet(indexPath: IndexPath) {
        print("didUpdateFlashcard called in set vc")
        viewmodel.getAllFlashcards()
        let indexPathSetCell = IndexPath(row: indexPath.row, section: 0)
        let indexPathSmallSetCell = IndexPath(row: indexPath.row, section: 1)
        let newIndexPathForList = indexPath.row == 0 ? IndexPath(row: 0, section: 0) : IndexPath(row: max(0, indexPath.row - 1), section: 0)
        
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.viewmodel.isSectionCollapsed() ?
                self.collectionView.deleteItems(at: [indexPathSetCell, indexPathSmallSetCell]) :
                self.collectionView.deleteItems(at: [indexPathSetCell])

            }, completion: { finished in
                if finished{
                    self.configureScrollBehavior(indexPath: indexPath, updateDelete: 0)
                    
                }
            })
        }
        updateFlashCardInListViewControllerDelegate?.didDeleteFlashCardInListViewControllerFromSetViewController(indexPath: indexPath, newIndexPathForList: newIndexPathForList)
    }
    
    
    func configureScrollBehavior(indexPath: IndexPath, updateDelete:Int){
        
        var newPosition = updateDelete == 0 ? indexPath.row - 1 :  indexPath.row// Default to one less than the deleted item
        // Check bounds and adjust if necessary
        if newPosition < 0 && self.viewmodel.numberOfFlashCards > 0 {
            newPosition = 0 // Set to the first item if we deleted the first item
        } else if newPosition >= self.viewmodel.numberOfFlashCards {
            newPosition = max(0, self.viewmodel.numberOfFlashCards - 1)  // Set to the last item if out of bounds
            
        }
        if self.viewmodel.numberOfFlashCards > 0 {
            let indexPathSetCell = IndexPath(row: newPosition, section: 0)
            let indexPathSmallSetCell = IndexPath(row: newPosition, section: 1)
            self.viewmodel.currentIndex = indexPathSmallSetCell.row
            switch newPosition {
            case 0:
                self.collectionView.reloadItems(at: [indexPathSmallSetCell])
                self.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                break
            case self.viewmodel.numberOfFlashCards-1 :
                self.collectionView.scrollToItem(at: indexPathSetCell , at: .centeredHorizontally, animated: false)
                break
            default:
                self.collectionView.scrollToItem(at: indexPathSetCell, at: .centeredHorizontally, animated: true)
                break
            }
        }
    }
}

//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import UIKit

class FlashCardGameViewController: UIViewController{
   
    
    
    let viewmodel:FlashcardSetViewModel
    
    let flashcardGameViewModel :FlashCardGameViewModel
    
    
    
    private var currentIndex = 0
    
    private var cardViews:[FlashCardGameCollectionViewCell] = []
    
    
    init(viewmodel: FlashcardSetViewModel) {

        self.viewmodel = viewmodel
        self.flashcardGameViewModel = FlashCardGameViewModel(topicID: viewmodel.topicID)
        super.init(nibName: nil, bundle: nil)
        // super.init(nibName: nil, bundle: nil)
        //super.init(transitionStyle: .pageCurl  , navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        view.backgroundColor = .clear

        setupCardViews()
    }
//    func setupConstraints(){
//        NSLayoutConstraint.activate([
//            view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 100),
//            view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//        ])
//    }

    

    override func viewDidAppear(_ animated: Bool) {
        viewmodel.viewControllerCurrentlyAppearing = 2
        flashcardGameViewModel.getAllFlashcardsForGame()
        //flashcardGameViewModel.gameFlashCards = viewmodel.getAllFlashcardsForListSet()



        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        viewmodel.viewControllerCurrentlyAppearing = 2
        super.viewWillAppear(animated)

    }
    
//    lazy var pageViewController: UICollectionView = {
//        let
//        
//    }()
    
}

extension FlashCardGameViewController{
    
    private func setupCardViews(){
        flashcardGameViewModel.getAllFlashcardsForGame()
        

        for (index,flashcard) in flashcardGameViewModel.gameFlashCards.reversed().enumerated(){
          //  print("fc: \(flashcardGameViewModel.gameFlashCards[index].front)")
    
            let cardView = FlashCardGameCollectionViewCell(frame: .zero)
            cardView.configure(flashcard: flashcard, bottomTopStyle: 0)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(cardView)
            NSLayoutConstraint.activate([
                cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
            ])
            //im not sure about this, we'll see
           // cardView.transform = CGAffineTransform(translationX: 0, y: CGFloat(index*2))
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            cardView.addGestureRecognizer(panGesture)
            print(index)
            cardViews.append(cardView)
            //print("gesture added")
           
           // print("gesture added end")

            
            
            
            
            
        }
        
        
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view as? FlashCardGameCollectionViewCell,
        let index = cardViews.firstIndex(of: card) else { 
            print("should not return ")
            return }
       // print("cv count \(cardViews.count)")
        print("cv count \(index)")


     
        
          let point = gesture.translation(in: view)
          let xFromCenter = card.center.x - view.center.x
          
          switch gesture.state {
          case .began:
              break
              
          case .changed:
   

              card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
              card.transform = CGAffineTransform(rotationAngle: xFromCenter / view.frame.width * 0.2)
              
              if xFromCenter > 0 {
                  cardViews[safe: index - 1 ]?.backgroundColor = .green.withAlphaComponent(0.5)
              } else if xFromCenter < 0 {
                  cardViews[safe: index - 1]?.backgroundColor = .red.withAlphaComponent(0.5)
              }
              
          case .ended:
 
              if abs(xFromCenter) > 100 {
                  UIView.animate(withDuration: 0.2, animations: {
                      card.center = CGPoint(x: xFromCenter > 0 ? self.view.frame.width * 1.5 : -self.view.frame.width * 0.5, y: card.center.y)
                      card.alpha = 0
                  }) { [weak self] _ in
                      
                      guard let self = self else { return }
                      card.removeFromSuperview()
                      currentIndex += 1
                      
                      if currentIndex < flashcardGameViewModel.gameFlashCards.count {
                          resetCardPositions()
                      }
                  }
              } else {
                  print(".ended else stmnt")
                  UIView.animate(withDuration: 0.2) { [weak self] in
                      guard let self = self else{return}
                      
                      card.center = self.view.center
                      card.transform = .identity
                      self.cardViews[safe: index - 1 ]?.backgroundColor = .clear
                  }
              }
              
          default:
              print("default called")
              break
          }
      }
    
    private func resetCardPositions() {
        print("reset pos")
        for (index,cardView) in cardViews.enumerated() {
              UIView.animate(withDuration: 0.2) {
                  cardView.center = self.view.center
                 // cardView.transform = CGAffineTransform(translationX: 0, y: CGFloat(index * 2))
                  cardView.alpha = 1
                  cardView.backgroundColor = .clear
              }
          }
      }
    
    
    
    
    
    
}


extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


















//extension FlashCardGameViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let flashcardVC = viewController as? viewcontroller,
//              let index = flashcardVC.pageIndex,
//              index > 0 else { return nil }
//        
//        return viewControllerAtIndex(index - 1)
//
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let flashcardVC = viewController as? viewcontroller,
//              let index = flashcardVC.pageIndex,
//              index < flashcardGameViewModel.numberOfGameFlashCards - 1 else { return nil }
//        
//        return viewControllerAtIndex(index + 1)
//    }
//    
//    
//}



//class viewcontroller:UIViewController{
//    var fView : FlashCardGameCollectionViewCell
//    var flashcard: FlashcardViewModel
//    let pageIndex: Int?
//    
//    init( flashcard: FlashcardViewModel, pageIndex:Int) {
//        self.fView = FlashCardGameCollectionViewCell()
//        self.flashcard = flashcard
//        self.pageIndex = pageIndex
//        super.init(nibName: nil, bundle: nil)
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//        setupConstriants()
//
//    }
//    private func setup(){
//        view.addSubview(fView)
//        fView.translatesAutoresizingMaskIntoConstraints = false
//
//        fView.configure(flashcard: flashcard,bottomTopStyle: 0)
//    }
//    
//    private func setupConstriants(){
//        NSLayoutConstraint.activate([
//            fView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            fView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
//            fView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
//            fView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
//        
//        ])
//    }
//    
//    
//    
//}
    
//    let viewmodel:FlashcardSetViewModel
//    
//    let flashcardGameViewModel :FlashCardGameViewModel
//    
//    private var currentIndex = 0
//
//    
//    private var leftSwipeGesture: UISwipeGestureRecognizer!
//    private var rightSwipeGesture: UISwipeGestureRecognizer!
//    private var backgroundView: UIView!
//
//    
//    
//    init(viewmodel: FlashcardSetViewModel) {
//        self.viewmodel = viewmodel
//        self.flashcardGameViewModel = FlashCardGameViewModel(topicID: viewmodel.topicID)
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    
//    lazy var collectionView: UICollectionView = {
//        
//        let layout = UICollectionViewCompositionalLayout {  sectionIndex, enviroment in
//            return  self.flashcardSet()
//        }
//        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        v.backgroundColor = .clear
//        v.translatesAutoresizingMaskIntoConstraints = false
//        
//        v.register(FlashCardGameCollectionViewCell.self, forCellWithReuseIdentifier: "setCell")
//        
//       
////        view.addGestureRecognizer(leftSwipeGesture)
////        view.addGestureRecognizer(rightSwipeGesture)
//        
//       // v.register(FlashCardSetCollectionViewCell.self, forCellWithReuseIdentifier: "smallSetCell")
//       // v.register(FlashcardSmallSetViewControllerHeader.self,  forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
//        //let longPress = UILongPressGestureRecognizer(target: self, action: #selector( handleLongPress(gesture:)))
//       // v.addGestureRecognizer(longPress)
//        v.isScrollEnabled = false
//        v.delegate = self
//        v.dataSource = self
//        return v
//    }()
//
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//        
//         setup()
//         setupGestureRecognizers()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        viewmodel.viewControllerCurrentlyAppearing = 2
//        flashcardGameViewModel.getAllFlashcardsForGame()
//        //flashcardGameViewModel.gameFlashCards = viewmodel.getAllFlashcardsForListSet()
//        
//        
//        
//        super.viewDidAppear(animated)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        viewmodel.viewControllerCurrentlyAppearing = 2
//        super.viewWillAppear(animated)
//
//    }
//
//
//}
//
//extension FlashCardGameViewController{
//    private func setup(){
//        
//        view.addSubview(collectionView)
//
//        backgroundView = UIView()
//        backgroundView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.backgroundView = backgroundView
//       //view.addSubview(backgroundView)
//
//
//
//        
//        setupConstraints()
//        
//    }
//    private func setupConstraints(){
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor,constant: 10),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),
//            
//            backgroundView.topAnchor.constraint(equalTo: collectionView.topAnchor),
//            backgroundView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
//
//        
//        ])
//        
//    }
//    
//
//    private func setupGestureRecognizers() {
//        leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        leftSwipeGesture.direction = .left
//        
//        rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
//        rightSwipeGesture.direction = .right
//        view.addGestureRecognizer(leftSwipeGesture)
//        view.addGestureRecognizer(rightSwipeGesture)
//
//    }
//    
//    
//    
//}
//
//extension FlashCardGameViewController{
//    func flashcardSet() -> NSCollectionLayoutSection{
//        
//        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1) )
//        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.75))
//
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [fc])
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        return section
//    }
//}
//
//
//extension FlashCardGameViewController {
//    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
//        print("swipe gesture rec")
//        switch gesture.direction {
//        case .left:
//            animateBackgroundColor(.green)
//        case .right:
//            animateBackgroundColor(.red)
//        default:
//            break
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
//            self?.moveToNextFlashcard()
//        }
//    }
//    
//    private func animateBackgroundColor(_ color: UIColor) {
//        UIView.transition(with: self.collectionView, duration: 0.5, options: .transitionCurlDown, animations: {
//                self.backgroundView.backgroundColor = color
//            //self.collectionView.
//
//        },completion: {_ in 
//           self.backgroundView.backgroundColor = .clear
//
//            
//        })
////        UIView.animate(withDuration: 0.3) {
////            self.backgroundView.backgroundColor = color
////        } completion: { _ in
////            UIView.animate(withDuration: 0.3) {
////                self.backgroundView.backgroundColor = .clear
////            }
////        }
//    }
//    
//    private func moveToNextFlashcard() {
//        currentIndex = (currentIndex + 1) % flashcardGameViewModel.numberOfGameFlashCards
//        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
//    }
//    
//    
//    
//    
// 
//}

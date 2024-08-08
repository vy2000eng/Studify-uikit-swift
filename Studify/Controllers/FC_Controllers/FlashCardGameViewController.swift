//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 7/21/24.
//

import UIKit


class CounterLabelClass:UIView{
   
    lazy var label = createCountLabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func createCountLabel()->UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .gray
        return label
        
    }
    private func setupConstraints(){
        _ = label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

class RightCounterLabelClass:CounterLabelClass{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
class LeftCounterLabelClass:CounterLabelClass{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class FlashCardGameViewController: UIViewController{
    
    let viewmodel:FlashcardSetViewModel
    
    let flashcardGameViewModel :FlashCardGameViewModel
    
    private var currentIndex = 0
    
    private var cardViews:[FlashCardGameCollectionViewCell] = []
    
    private var rightCounterView: RightCounterLabelClass = {
        let view = RightCounterLabelClass()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var leftCounterView: LeftCounterLabelClass = {
        let view = LeftCounterLabelClass()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewmodel: FlashcardSetViewModel) {
        
        self.viewmodel = viewmodel
        self.flashcardGameViewModel = FlashCardGameViewModel(topicID: viewmodel.topicID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCounterViews()
        setupConstraintsForCounters()
        
        setupCardViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewmodel.viewControllerCurrentlyAppearing = 2
        flashcardGameViewModel.getAllFlashcardsForGame()
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewmodel.viewControllerCurrentlyAppearing = 2
        super.viewWillAppear(animated)
    }
}

extension FlashCardGameViewController{
    
    private func setupCounterViews(){
        view.addSubview(rightCounterView)
        view.addSubview(leftCounterView)
    }
    
    private func setupConstraintsForCounters(){
        print("counters func")
        // Right Counter View
        NSLayoutConstraint.activate([
            rightCounterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                 rightCounterView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                 rightCounterView.widthAnchor.constraint(equalToConstant: 80),
                 rightCounterView.heightAnchor.constraint(equalToConstant: 40),
                 
                 // Left Counter View
                 leftCounterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                 leftCounterView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                 leftCounterView.widthAnchor.constraint(equalToConstant: 80),
                 leftCounterView.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
        //temp code
        rightCounterView.label.text = "10"
        leftCounterView.label.text  = "10"
 
    }
    
    private func setupCardViews(){
        flashcardGameViewModel.getAllFlashcardsForGame()
        
        for (index,flashcard) in flashcardGameViewModel.gameFlashCards.reversed().enumerated(){
            
            let cardView = FlashCardGameCollectionViewCell(frame: .zero)
            cardView.configure(flashcard: flashcard, bottomTopStyle: 0)
            cardView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(cardView)
            NSLayoutConstraint.activate([
                cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 50),
                cardView.widthAnchor.constraint(equalTo: view.widthAnchor ,multiplier: 0.95),
                cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
            ])
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            cardView.addGestureRecognizer(panGesture)
            print(index)
            cardViews.append(cardView)
            
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        guard let card = gesture.view as? FlashCardGameCollectionViewCell ,
              let index = cardViews.firstIndex(of: card) else { return }
        
        
        let point = gesture.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        switch gesture.state {
            
        case .began:
            break
            
        case .changed:
            
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            card.transform = CGAffineTransform(rotationAngle: xFromCenter / view.frame.width * 0.2)
            
            if xFromCenter > 0 {
                cardViews[safe: index ]?.layer.borderColor = UIColor(resource: .darkGreen).cgColor
                
            } else if xFromCenter < 0 {
                cardViews[safe: index ]?.layer.borderColor = UIColor(resource: .darkRed).cgColor
                
            }
            
        case .ended:
            
            if abs(xFromCenter) > 100 {
                UIView.animate(withDuration: 0.2, animations: {
                    card.center = CGPoint(x: xFromCenter > 0 ? self.view.frame.width * 2 : -self.view.frame.width * 0.5, y: card.center.y + 50)
                    card.alpha = 0
                }) { [weak self] _ in
                    
                    guard let self = self else { return }
                    card.removeFromSuperview()
                    deactivateConstraints(cardView: card)
                    
                    currentIndex += 1
                    
                    if currentIndex < flashcardGameViewModel.gameFlashCards.count {
                        resetCardPositions()
                    }
                    else{
                        initiateConclusionView()
                    }
                }
            } else {
                print(".ended else stmnt")
                UIView.animate(withDuration: 0.2) { [weak self] in
                    guard let self = self else{return}
                    card.center = CGPoint(x: view.self.center.x, y: view.self.center.y + 50)
                    card.transform = .identity
                    self.cardViews[safe: index  ]?.layer.borderColor = viewmodel.background.cgColor
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
            UIView.animate(withDuration: 0.2) { [weak self ] in
                guard let self = self else {return}
                cardView.center = CGPoint(x: view.self.center.x, y: view.self.center.y + 50)
                cardView.alpha = 1
                cardView.layer.borderColor = viewmodel.background.cgColor
                cardView.backgroundColor = viewmodel.background
            }
        }
    }
    
    private func initiateConclusionView(){
        
        cardViews.forEach { $0.removeFromSuperview() }
        cardViews.removeAll()
        let resultsView = GameConclusionView()
        resultsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultsView)
        resultsView.configure(numberOfLearnedFlashCards: 5, numberOfStillLearningFlashCards: 5, viewmodel:flashcardGameViewModel)
        
        NSLayoutConstraint.activate([
            resultsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            resultsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            resultsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            resultsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
        ])
    }
    
    private func deactivateConstraints(cardView:UIView){
        NSLayoutConstraint.deactivate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

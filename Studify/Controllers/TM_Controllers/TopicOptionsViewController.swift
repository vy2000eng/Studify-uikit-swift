//
//  FlashCardOptionsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 8/21/24.
//

import UIKit

struct Item: Hashable {
    var title: String
    var subtitle: String
    var image: UIImage
    init(title: String, subtitle: String, image: UIImage) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

let dataItems = [
    Item(title: "list/set", subtitle: "previews", image: UIImage(systemName: "list.bullet")!),
    Item(title: "study", subtitle: "play a study game", image: UIImage(systemName: "graduationcap")!),
    Item(title: "remember", subtitle: "create a mind palace", image: UIImage(systemName: "compass.drawing")!)
]

enum Section {
    case main
}

class TopicOptionsViewController: UIViewController, UICollectionViewDelegate{
                                  //FlashCardSetViewControllerDelegate, FlashCardListViewControllerDelegate {
//    func didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: IndexPath) {
//        <#code#>
//    }
//    
//    func didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: IndexPath) {
//        <#code#>
//    }
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    let topicID:UUID
    let topicIndexPath: IndexPath
    let viewmodel:TopicOptionsViewModel
    
    init(topicID:UUID, topicIndexPath: IndexPath){
        self.topicIndexPath = topicIndexPath
        self.topicID = topicID
        self.viewmodel = TopicOptionsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarTitle()
        configureCollectionView()
        configureDataSource()
        applyInitialData()
        view.backgroundColor = viewmodel.background
    }
}



//CLASS FUNCTIONS
extension TopicOptionsViewController{
    
    private func setupNavigationBarTitle(){
        title = "FlashCard Menu"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                   .font:viewmodel.subtitleFont ]
        
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                        .font: viewmodel.titleFont]
        navigationController?.navigationBar.barTintColor = viewmodel.background
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    
    private func configureLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
        config.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: self.configureLayout())
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    
    private func configureDataSource(){
        
        let cellRegistration =
        UICollectionView.CellRegistration<UICollectionViewListCell, Item> { [weak self]
            (cell, indexPath, item) in
            guard let self = self else {return}
            
            var content = UIListContentConfiguration.cell()
            content.textProperties.color = viewmodel.fontColor
            content.attributedText = .create(string: item.title, font: viewmodel.titleFont, color: viewmodel.fontColor)
            content.secondaryAttributedText = .create(string: item.subtitle, font: viewmodel.subtitleFont, color: viewmodel.fontColor)
            content.image = item.image
    
            cell.contentConfiguration = content
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.backgroundView = backgroundView
            
            var selectedBackgroundConfig = UIView()
            backgroundView.backgroundColor = .clear

            
            selectedBackgroundConfig.backgroundColor = .blue.withAlphaComponent(0.5) // Slightly transparent when selected
            cell.selectedBackgroundView = selectedBackgroundConfig
            
            
        }
        
        datasource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView,
           cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
              return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath, item: item)
        })
    }
    
    private func applyInitialData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dataItems, toSection: .main)
        datasource.apply(snapshot, animatingDifferences: false)
    }
    
}

//DELEGATE
extension TopicOptionsViewController{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = FlashCardTabViewController(topicID: topicID, topicIndexPath: indexPath)
            
            navigationController?.pushViewController(vc, animated:true)
        }
        else if indexPath.row == 1{
            let vc = FlashCardGameViewController(topicID: topicID)
            navigationController?.pushViewController(vc, animated:true)
        }
        collectionView.deselectItem(at: indexPath, animated: true)

    }
}

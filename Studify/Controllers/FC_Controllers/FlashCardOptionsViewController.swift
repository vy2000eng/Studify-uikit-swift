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

class FlashCardOptionsViewContoleer: UIViewController, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Item>!
    
    
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: self.configureLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
           configureDataSource()
           applyInitialData()
    }
    
    private func configureDataSource(){
        let cellRegistration =
          UICollectionView.CellRegistration<UICollectionViewListCell, Item> {
              (cell, indexPath, item) in
                var content = cell.defaultContentConfiguration()
                content.text = item.title
                content.textProperties.color = UIColor.blue
                content.secondaryText = item.subtitle
                content.image = item.image
                cell.contentConfiguration = content
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

extension FlashCardOptionsViewContoleer{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    
}

//
//  SubjectDetailsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/4/24.
//

import UIKit

enum sectionType{
    case topics
    case maps
}
//
//class sections{
//    let header: TopicMapHeaderViewCell
//    let topicData: SubjectTopicViewCell
//    let mapData: SubjectMapViewCell
//    
//    init(header: TopicMapHeaderViewCell, topicData: SubjectTopicViewCell, mapData: SubjectMapViewCell) {
//        self.header = header
//        self.topicData = topicData
//        self.mapData = mapData
//    }
//    
//}
//
//let sectionTitles = ["topics", "maps"]
//
//class Sections{
//    let header: String
//    let topicData: TopicViewModel
//    let mapData: MapViewModel
//    
//    init(header: String, topicData: TopicViewModel, mapData: MapViewModel) {
//        self.header = header
//        self.topicData = topicData
//        self.mapData = mapData
//    }
//    
//}
//enum sectiontype: Hashable{
//    case topics(listItem<TopicMapHeaderViewCell, MapViewModel>)
//    case maps(listItem<TopicMapHeaderViewCell, TopicViewModel>)
//}
//
//
//
//struct listItem<Header: TopicMapHeaderViewCell, Data:Hashable> : Hashable{
//    let header: TopicMapHeaderViewCell
//    let topicitems :[Data]
//}


class TopicMapViewController: UIViewController,AddNewTopicViewControllerDelgate, AddNewMapViewControllerDelgate {
    
    //MARK: this word begin

    let viewmodel : TopicMapViewModel
    let sectionTitles = ["topics", "maps"]
    var isRowSectionCollapsed = false
    //var dataSource: UICollectionViewDiffableDataSource<sectionType, AnyHashable>!
   // var snapshot = NSDiffableDataSourceSnapshot<sectionType, AnyHashable>()
    
    init(subjectID: UUID){
        self.viewmodel = TopicMapViewModel(subjectID: subjectID, sectionsCount: 2)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.headerTopPadding = 10
        layoutConfig.showsSeparators = false
    
        layoutConfig.headerMode = .supplementary
       // layoutConfig.estimatedItemSize = UICollectionViewFlowLayout.automaticSize  // If you use FlowLayout

//        layoutConfig.leadingSwipeActionsConfigurationProvider = { [unowned self] indexPath in
//            var snapshot = dataSource.snapshot()
//            let deleteAction = UIContextualAction(style: .destructive, title: "delete") { action, sourceView, actionPerformed in
//   
//                if indexPath.section == 0{
//                    self.deleteTopic(at: indexPath)
//                }else {
//                    self.deleteMap(at: indexPath)
//                }
//                actionPerformed(true)
//            }
//
//            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
//            swipeConfiguration.performsFirstActionWithFullSwipe = true  // This makes the action execute fully on a full swipe
//            return .init(actions: [deleteAction])
//        }
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        let v = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
        v.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        v.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        v.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
        v.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "fallbackIdentifier")

        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewCompositionalLayout()
//
//    }()
//    private let section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "topics and maps"
         navigationController?.navigationBar.prefersLargeTitles = true
         let attributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 12, weight: .bold), // You can adjust the size and weight
             .foregroundColor: UIColor.darkGray // Change the color as needed
         ]

        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        view.addSubview(collectionView)
        collectionView.selfSizingInvalidation = .disabled
       // collectionView.bounces  = false
        setupConstraints()

        configureCollectionView()
        
        
        

       // configureDataSource()
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()
       // reloadData()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
////         viewmodel.getAllTopics()
////         viewmodel.getAllMaps()
////        reloadData()
//    }
}

extension TopicMapViewController{
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
    }
    private func configureCollectionView() {
        collectionView.delegate = self
      //  collectionView.dataSource = self
        collectionView.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        collectionView.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
    }
    
//    private func configureDataSource() {
//        dataSource = UICollectionViewDiffableDataSource<sectionType, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
//            if let topic = item as? TopicViewModel {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! SubjectTopicViewCell
//                cell.configure(with: topic)
//                return cell
//            } else if let map = item as? MapViewModel {
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! SubjectMapViewCell
//                cell.configure(with: map)
//                return cell
//            }
//            fatalError("Unknown item type")
//        })
//        
//        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
//            // Ensure headers or footers are dequed
//            guard let self = self, kind == UICollectionView.elementKindSectionHeader else {
//                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "defaultHeader", for: indexPath)
//            }
//            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell else {
//                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "defaultHeader", for: indexPath)
//            }
//            header.sectionTitle.text = sectionTitles[indexPath.section]
//            header.addButton.tag = indexPath.section
//            header.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
//            let isCollapsed = self.viewmodel.collapsedSections[indexPath.section]
//            let imageName = isCollapsed ?  "arrow.left.arrow.right" : "arrow.up.arrow.down"
//            header.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)
//            header.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
//           // header.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)
//            header.collapseButton.tag = indexPath.section
//            return header
//        }
//    }
    
    //MARK: this is a bad implementation, I know theres a better way to do it, but we'll save it for later.
//    func reloadData() {
//    
//        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<sectiontype>()
//        let topicHeaderListItem = listItem<TopicMapHeaderViewCell, TopicViewModel>(header: TopicMapHeaderViewCell, topicitems: viewmodel.topics)
//        
//        sectionSnapshot.append([topicHeaderListItem])
//        
////        let headerListItem = listItem
////        headerListItem.
////        headerListItem.sectionTitle.text = "topics"
//  //      sectionSnapshot.append([headerListItem])
////        let arr = viewmodel.topics
////        sectionSnapshot.append(arr, to: headerListItem)
//        
//        
//        
////        snapshot = dataSource.snapshot()
////        snapshot.appendSections([.topics])
////        
////        if !viewmodel.collapsedSections[0] {
////            snapshot.appendItems(viewmodel.topics, toSection: .topics)
////            snapshot.reloadSections([.topics])
////        }else {
////            snapshot.deleteItems(viewmodel.topics)
////            snapshot.reloadSections([.topics])
////        }
////        snapshot.appendSections([.maps])
////        if !viewmodel.collapsedSections[1] {
////            snapshot.appendItems(viewmodel.maps, toSection: .maps)
////            snapshot.reloadSections([.maps])
////        }else {
////            snapshot.deleteItems(viewmodel.maps)
////            snapshot.reloadSections([.maps])
////        }
////        dataSource.apply(snapshot, animatingDifferences: true)
//        
//    }
//    
//    func getAllData() {
//        viewmodel.getAllTopics()
//        viewmodel.getAllMaps()
//        reloadData()  // Make sure to call this on the main thread if fetching is asynchronous
//    }
//    @objc func handleAddButton(_ sender: UIButton) {
//        let section = sender.tag
//        if section == 0{
//            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
//            vc.delegate = self
//            snapshot = dataSource.snapshot()
//            navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
//            vc.delegate = self
//            snapshot = dataSource.snapshot()
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
//    @objc func handleCollapseButton(_ sender:UIButton){
//        let section = sender.tag
//        viewmodel.toggleSection(section)
//        var snapshot = dataSource.snapshot()
//       // snapshot.reloadSections([section == 0 ? .topics : .maps])
//        
//       // var sectionSnapshot = dataSource.supplementaryViewProvider
//        
//
//       // snapshot.
//
//        switch section{
//        case 0: 
//            if viewmodel.isSectionCollapsed(section){
//                
//                snapshot.deleteItems(viewmodel.topics)
//                //snapshot.deleteSections([.topics])
//            }else{
//                //snapshot.appendSections([.topics])
//                snapshot.appendItems(viewmodel.topics, toSection: .topics)
//            }
//            break
//        case 1:
//            if viewmodel.isSectionCollapsed(section){
//                //snapshot.deleteSections([.maps])
//                snapshot.deleteItems(viewmodel.maps)
//            }else{
//               // snapshot.appendSections([.maps])
//
//                snapshot.appendItems(viewmodel.maps, toSection: .maps)
//            }
//            break
//        default:
//            print("fatal error uh oh!")
//            break
//        }
//       // snapshot.reloadSections([section == 0 ? .topics : .maps])
//
//        dataSource.apply(snapshot, animatingDifferences: true)
//        snapshot = dataSource.snapshot()
//         snapshot.reloadSections([section == 0 ? .topics : .maps])
//        dataSource.apply(snapshot, animatingDifferences: true)
//
//
//        
//
//    }
    
    func updateTopicSection(){
        print("updateTopic called")
        viewmodel.getAllTopics()
       // snapshot.appendItems([viewmodel.topic(by: viewmodel.numberOfTopics-1)], toSection: .topics)
       // snapshot.reloadSections([.topics])
       // dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateMapSection(){
        print("updateMap called")
        viewmodel.getAllMaps()
       // snapshot.appendItems([viewmodel.map(by: viewmodel.numberOfMaps-1)], toSection: .maps)
       // dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func didUpdateTopic() {
        print("updateTopic called")
        updateTopicSection()
    }
    
    func didUpdateMap(){
        print("updateSection called")
        updateMapSection()
    }
  
}

//MARK: this word end


//class AnimatedDiffableDataSource: UICollectionViewDiffableDataSource<sectionType, AnyHashable> {
//    override func apply(_ snapshot: NSDiffableDataSourceSnapshot<sectionType, AnyHashable>, animatingDifferences: Bool = true, completion: (() -> Void)? = nil) {
//        if animatingDifferences {
//            UIView.animate(withDuration: 0.5, animations: {
//                super.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
//            })
//        } else {
//            super.apply(snapshot, animatingDifferences: animatingDifferences, completion: completion)
//        }
//    }
//}


    
//    let viewmodel : TopicListViewModel
//    
//
//    init(subjectID: UUID){
//        self.viewmodel = TopicListViewModel(subjectID: subjectID)
//        super.init(nibName: nil, bundle: nil)
//
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    lazy var label: UILabel = {
//       let v = UILabel()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.text = "a text"
//        return v
//    }()
//    
//    lazy var addFlashCardSetButton: UIButton = {
//       let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("add topic", for:.normal )
//        v.backgroundColor = UIColor.systemGray
//        v.addTarget(self, action: #selector(addTopic(sender: )), for: .touchUpInside)
//        return v
//    }()
//    
//    
//    lazy var addFlashCardButton: UIButton = {
//       let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("get all topics", for:.normal )
//        v.backgroundColor = UIColor.systemGray
//        v.addTarget(self, action: #selector(getAllTopics(sender: )), for: .touchUpInside)
//        return v
//    }()
//    
//    
//    lazy var stack: UIStackView = {
//        let v = UIStackView()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.axis = .vertical
//        v.alignment = .fill
//        v.backgroundColor = UIColor.systemGray
//        v.spacing = UIStackView.spacingUseSystem
//        return v
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//}
//
//extension SubjectDetailsViewController{
//    
//    private func setup(){
//        view.backgroundColor = UIColor.systemBackground
//        view.addSubview(stack)
//        stack.addArrangedSubview(addFlashCardSetButton)
//        stack.addArrangedSubview(addFlashCardButton)
//        stack.addArrangedSubview(label)
//        setupConstraints()
//    }
//    
//    private func setupConstraints(){
//        NSLayoutConstraint.activate([
//            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
//    }
//    
//    @objc
//    private func addTopic(sender: UIButton){
//        viewmodel.insertTopic( title: "a topic 2",id: UUID())
//        print("add fcs button clicked")
//    }
//    
//    @objc
//    private func getAllTopics(sender: UIButton){
//        viewmodel.getAllTopics()
//    }
//}




//
//  SubjectDetailsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/4/24.
//

import UIKit



class TopicMapViewController: UIViewController,AddNewTopicViewControllerDelgate, AddNewMapViewControllerDelgate {
    
    //MARK: this word begin

    let viewmodel : TopicMapViewModel
  //  let sectionTitles = ["topics", "maps"]
    var isRowSectionCollapsed = false

    
    init(subjectID: UUID){
        self.viewmodel = TopicMapViewModel(subjectID: subjectID, sectionsCount: 2)
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {


        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
              let item = NSCollectionLayoutItem(layoutSize: itemSize)

              // Group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(112))
              // Directly creating a vertical group using an array of items
              let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

              // Section
              let section = NSCollectionLayoutSection(group: group)

              // Header
              let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
              let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
              header.pinToVisibleBounds = true  // This makes the header sticky

              section.boundarySupplementaryItems = [header]

              return section
            }
            
            let v = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        v.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        v.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        v.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
        v.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "fallbackIdentifier")

        v.delegate = self
        v.dataSource = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    

    
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
        setupConstraints()

        configureCollectionView()
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()

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
        collectionView.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        collectionView.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
    }
    
    
    func updateTopicSection(){
        print("updateTopic called")
        viewmodel.getAllTopics()

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




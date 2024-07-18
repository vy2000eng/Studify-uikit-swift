//
//  SubjectDetailsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/4/24.
//

import UIKit


protocol UpdateTopicAndMapCountInSubjectCollectionViewDelegate:AnyObject{
    func didUpdateTopicMapCountInSubjectCollectionViewFromTopicMapViewController(subjectIndexPath: IndexPath)
}

class TopicMapViewController: UIViewController,AddNewTopicViewControllerDelgate, AddNewMapViewControllerDelgate,FlashCardSetViewControllerDelegate,FlashCardListViewControllerDelegate {
    
    //MARK: this word begin
    let viewmodel : TopicMapViewModel
    let subjectIndexPath: IndexPath
    var subjectTitle: String
    var isRowSectionCollapsed = false
    weak var updateTopicAndMapCountInSubjectCollectionViewDelegate: UpdateTopicAndMapCountInSubjectCollectionViewDelegate?
    
    init( subject: SubjectViewModel, subjectIndexPath:IndexPath){
        self.viewmodel = TopicMapViewModel(subjectID: subject.id)
        self.subjectTitle = subject.name
        self.subjectIndexPath = subjectIndexPath
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(112))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10 // This adds vertical spacing between cells
            //  section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
            header.pinToVisibleBounds = true  // This makes the header sticky
            section.boundarySupplementaryItems = [header]
            return section
        }
        
        let v = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        v.backgroundColor = .clear
        v.delegate = self
        v.dataSource = self
        v.register(TopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        v.register(MapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        v.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader , withReuseIdentifier: "headerCell")
        v.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "fallbackIdentifier")
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: .themeDidChange, object: nil)
        view.backgroundColor = viewmodel.background
        title = subjectTitle
        
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                   .font:viewmodel.subtitleFont
                                                                    ]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                        .font: viewmodel.titleFont]

        navigationController?.navigationBar.barTintColor = viewmodel.background
        navigationController?.navigationBar.prefersLargeTitles = true

        
       
        
        
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
        view.addSubview(collectionView)
        setupConstraints()
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()
    }
    deinit {
          NotificationCenter.default.removeObserver(self)
      }
}

extension TopicMapViewController{
    
    @objc
    func applyTheme(){
        view.backgroundColor = viewmodel.background
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                   .font:viewmodel.subtitleFont
                                                                    ]
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewmodel.fontColor,
                                                                        .font: viewmodel.titleFont]

        navigationController?.navigationBar.barTintColor = viewmodel.background
        navigationController?.navigationBar.prefersLargeTitles = true
       
        collectionView.reloadData()


    }

    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func createOptionsBarButtonItem() -> UIBarButtonItem {
        let addATopicAction = UIAction(title: "add topic", image: UIImage(systemName: "doc")) { _ in
            let vc = AddNewTopicViewController(subjectID: self.viewmodel.subjectID)
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)

            self.present(navController,animated: true)
            print("add Topic")
        }
        
        let addMapAction = UIAction(title: "add map", image: UIImage(systemName: "map")) { _ in
            let vc = AddNewMapViewController(subjectID: self.viewmodel.subjectID)
            vc.delegate = self
            let navController = UINavigationController(rootViewController: vc)

            self.present(navController,animated: true)
           // self.navigationController?.pushViewController(vc, animated: true)
            print("add map")
        }
        
        let menu = UIMenu(title: "add options", children: [addATopicAction, addMapAction])
        
        return UIBarButtonItem(image: UIImage(systemName: "text.badge.plus"), menu: menu)
    }
    


    func updateNumberOfFlashcardsInTopicSection(indexPath:IndexPath){
        viewmodel.getAllTopics()
    
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [indexPath])
            })
        }
        
    }
    
    func didUpdateTopic() {
        print("updateTopic called")
        updateSection(type: .topics)

    }
    
    func didUpdateMap(){
        print("updateSection called")
        updateSection(type: .maps)

    }
    
    func didUpdateNumberOfFlashcardsFromFlashCardSetViewController(indexPath: IndexPath) {
        updateNumberOfFlashcardsInTopicSection(indexPath: indexPath)

    }
    func didUpdateNumberOfFlashcardsFromFlashCardListViewController(indexPath: IndexPath) {
        updateNumberOfFlashcardsInTopicSection(indexPath: indexPath)

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




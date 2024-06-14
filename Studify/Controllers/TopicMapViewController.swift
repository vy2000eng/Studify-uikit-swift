//
//  SubjectDetailsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/4/24.
//

import UIKit


//enum Sec

enum sectionType{
    case topics
    case maps
}


class TopicMapViewController: UIViewController {
    let viewmodel : TopicMapViewModel
    let sectionTitles = ["topics", "maps"]
    var isRowSectionCollapsed = false
    
    init(subjectID: UUID){
        self.viewmodel = TopicMapViewModel(subjectID: subjectID, sectionsCount: 2)
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {

        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
            
        layoutConfig.headerMode = .supplementary
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        let v = UICollectionView(frame: view.bounds, collectionViewLayout: listLayout)
        v.translatesAutoresizingMaskIntoConstraints = false

        
        return v
    }()
   
    var dataSource: UICollectionViewDiffableDataSource<sectionType, AnyHashable>!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
      
        title = "topics and maps"
         navigationController?.navigationBar.prefersLargeTitles = true

         // Using a built-in system font with a different weight
         let attributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 28, weight: .bold), // You can adjust the size and weight
             .foregroundColor: UIColor.darkGray // Change the color as needed
         ]

         navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
        view.addSubview(collectionView)
        configureCollectionView()
        configureDataSource()
        setupConstraints()
        //reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()
        reloadData()



    }
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
        //collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
        collectionView.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
        collectionView.register(TopicMapHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "defaultHeader")

    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<sectionType, AnyHashable>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            if let topic = item as? TopicViewModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topicCell", for: indexPath) as! SubjectTopicViewCell
                cell.configure(with: topic)
                return cell
            } else if let map = item as? MapViewModel {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapCell", for: indexPath) as! SubjectMapViewCell
                cell.configure(with: map)
                return cell
            }
            fatalError("Unknown item type")
        })
        
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
             // Ensure headers or footers are deque
            guard let self = self, kind == UICollectionView.elementKindSectionHeader else {
                    return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "defaultHeader", for: indexPath)
            }
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell else {
                return nil
            }
            
            //let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell

            header.sectionTitle.text = sectionTitles[indexPath.section]
            header.addButton.tag = indexPath.section
            header.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
            let isCollapsed = self.viewmodel.collapsedSections[indexPath.section]
               let imageName = isCollapsed ? "arrow.up.arrow.down" : "arrow.left.arrow.right"
            header.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)

            //let imageName = viewmodel.isSectionCollapsed(indexPath.section) ?  "arrow.up.arrow.down" : "arrow.left.arrow.right"
            header.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
            header.collapseButton.setImage(UIImage(systemName: imageName), for: .normal)

            header.collapseButton.tag = indexPath.section

            return header
         }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<sectionType, AnyHashable>()
        snapshot.appendSections([.topics])
 
        if !viewmodel.collapsedSections[0] {
            snapshot.appendItems(viewmodel.topics, toSection: .topics)
        }else {

            snapshot.deleteItems(viewmodel.topics)
        }

        snapshot.appendSections([.maps])
        if !viewmodel.collapsedSections[1] {
            snapshot.appendItems(viewmodel.maps, toSection: .maps)
        }else {
            snapshot.deleteItems(viewmodel.maps)
        }

        dataSource.apply(snapshot, animatingDifferences: true)

    }
    
    func getAllData() {
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()
        reloadData()  // Make sure to call this on the main thread if fetching is asynchronous
    }
    @objc func handleAddButton(_ sender: UIButton) {
        let section = sender.tag
        if section == 0{
            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
            navigationController?.pushViewController(vc, animated: true)

        }
        
        
    }
    @objc func handleCollapseButton(_ sender:UIButton){
        let section = sender.tag

        viewmodel.toggleSection(section)
        print(section)
        print(viewmodel.isSectionCollapsed(section))
        reloadData()
       // collectionView.reloadSections(IndexSet(integer: section))  // Ensures that the section headers are updated


    }
}

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




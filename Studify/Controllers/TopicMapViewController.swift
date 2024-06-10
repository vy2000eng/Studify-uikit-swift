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
        //v.backgroundColor = .systemBackground

        
        
        v.translatesAutoresizingMaskIntoConstraints = false
       // v.dataSource = self
       // v.delegate = self
//        v.register(SubjectTopicViewCell.self, forCellWithReuseIdentifier: "topicCell")
//        v.register(SubjectMapViewCell.self, forCellWithReuseIdentifier: "mapCell")
//        v.register(TopicMapHeaderViewCell.self, forCellWithReuseIdentifier: "topicCell")
        
        return v
    }()
    var dataSource: UICollectionViewDiffableDataSource<sectionType, AnyHashable>!

   // var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

//
//    let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, headerItem> {
//        (cell,indexPath,headerItem) in
//        var content  = cell.defaultContentConfiguration()
//        cell.contentConfiguration = headerItem.header
//        
//    }
//    lazy var tableView:UITableView = {
//        let v = UITableView()
//        v.separatorColor = UIColor.clear
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.dataSource = self
//        v.delegate = self
//        v.register(SubjectTopicViewCell.self, forCellReuseIdentifier: "topicCell")
//        v.register(SubjectMapViewCell.self, forCellReuseIdentifier: "mapCell")
//        v.register(TopicMapHeaderViewCell.self, forCellReuseIdentifier: "headerCell")
//        v.estimatedRowHeight = 500
//       // v.clipsToBounds = true
//        ///v.tableHeaderView = TopicMapHeaderViewCell()
//        v.rowHeight = UITableView.automaticDimension
//        
//        return v
//    }()
    
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
             // Ensure headers or footers are dequeued correctly
           
            guard let self = self else {
               // return nil
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "defaultHeader", for: indexPath)

            }
            guard kind == UICollectionView.elementKindSectionHeader else {
                //return nil
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "defaultHeader", for: indexPath)

            }
//            guard let self = self, kind == UICollectionView.elementKindSectionHeader else {
//                 // Return a default header view if the kind is not a header or self is nil
//                 return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "defaultHeader", for: indexPath) as? UICollectionReusableView
//             }
//
//             guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell else {
//                 // Return a default header view if the header cannot be dequeued properly
//                 return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "defaultHeader", for: indexPath) as? UICollectionReusableView
//             }

            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? TopicMapHeaderViewCell

                // let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as! TopicMapHeaderViewCell
            header!.sectionTitle.text = sectionTitles[indexPath.row]
            
            header!.addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
            header!.collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
            
            switch indexPath.section {
            case 0:
                //let collapseImageName = self.viewmodel.isSectionCollapsed(indexPath.section) ? "arrow.down.circle" : "arrow.up.circle"

               // var image = UIImage(named: header?.addButton.setImage(viewmodel.isSectionCollapsed(0) ? "arrow.up.arrow.down.square" : "arrow.left.arrow.right.square", for: .normal)

               // header?.addButton.setImage(image)
                    //header?.add
               // TopicMapHeaderViewCell.whatImage.toggle()
              //  header!.collapseButton.setImage(collapseImageName, for: .normal)
                header?.sectionTitle.text = sectionTitles[0]
                header?.collapseButton.tag = 0
                
            case 1:
                header!.sectionTitle.text = sectionTitles[1]
                header?.collapseButton.tag = 1

            default:
                header?.collapseButton.tag = -1
            }
            
            
            return header
         }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<sectionType, AnyHashable>()
        snapshot.appendSections([.topics])
        if !viewmodel.collapsedSections[0] {
            snapshot.appendItems(viewmodel.topics, toSection: .topics)
        }

        snapshot.appendSections([.maps])
        if !viewmodel.collapsedSections[1] {
            snapshot.appendItems(viewmodel.maps, toSection: .maps)
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
        // var image = UIImage(named: viewmodel.isSectionCollapsed(section) ? "arrow.up.arrow.down.square" : "arrow.left.arrow.right.square")
       // sender.
        print(section)
        viewmodel.toggleSection(section)
        viewmodel.getAllTopics()
        reloadData()
    }

    
    
    
}
    
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




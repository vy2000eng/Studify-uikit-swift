//
//  SubjectDetailsViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/4/24.
//

import UIKit

class TopicMapViewController: UIViewController {
    let viewmodel : TopicMapViewModel
    let sectionTitles = ["topics", "maps"]
    //var isRowSectionCollapsed = false
    
    init(subjectID: UUID){
        self.viewmodel = TopicMapViewModel(subjectID: subjectID, sectionsCount: 2)
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView:UITableView = {
        let v = UITableView()
        v.separatorColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(SubjectTopicViewCell.self, forCellReuseIdentifier: "topicCell")
        v.register(SubjectMapViewCell.self, forCellReuseIdentifier: "mapCell")
        v.register(TopicMapHeaderViewCell.self, forCellReuseIdentifier: "headerCell")
        v.estimatedRowHeight = 500
       // v.clipsToBounds = true
        ///v.tableHeaderView = TopicMapHeaderViewCell()
        v.rowHeight = UITableView.automaticDimension
        
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "subject details"

          // Customize navigation bar appearance
      
        title = "topics and maps"
         navigationController?.navigationBar.prefersLargeTitles = true

         // Using a built-in system font with a different weight
         let attributes: [NSAttributedString.Key: Any] = [
             .font: UIFont.systemFont(ofSize: 28, weight: .bold), // You can adjust the size and weight
             .foregroundColor: UIColor.darkGray // Change the color as needed
         ]

         navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
//
        
        view.addSubview(tableView)
        setupConstraints()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewmodel.getAllTopics()
        viewmodel.getAllMaps()
        tableView.reloadData()


    }
        
    
    
    
    
    
    
    
    
}

extension TopicMapViewController{
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
         
        
        ])
        
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




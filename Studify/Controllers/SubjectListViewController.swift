//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 5/26/24.
//

import UIKit
import CoreData
class SubjectListViewController: UIViewController {
    
    
    
    lazy var tableView: UITableView = {
       let v = UITableView()
        
      //  v.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom:100, right: 0)
        v.separatorColor = UIColor.clear
        
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemBackground
        v.dataSource = self
        v.delegate = self
        v.register(SubjectTableViewCell.self, forCellReuseIdentifier: "SubjectCell")
        //UIColor.systemBackground
        v.estimatedRowHeight = 600
        v.rowHeight = UITableView.automaticDimension
        
        return v
    }()

//    lazy var getTaskButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = UIColor.lightGray
//        v.setTitle("get tasks", for:.normal )
//        v.addTarget(self, action: #selector(getAllSubjects(sender: )), for: .touchUpInside)
//        return v
//    }()
    
    
    let viewModel = SubjectListViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        
        

        //view.backgroundColor = .red

        title = "Subjects"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        
        view.addSubview(tableView)

        
        setupConstraints()
//        view.addSubview(getTaskButton)
//        NSLayoutConstraint.activate([
//            getTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
//            getTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
//            getTaskButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//
//        ])

        

        //view.backgroundColor = .red
        // Do any additional setup after loading the view.
    }

   

}
extension SubjectListViewController{
    
    @objc
    private func addNewTask(){
        navigationController?.pushViewController(
            AddNewSubjectViewController(),
            animated: true)
        
    }
    
    
    private func setupConstraints(){
        
  
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
         
        
        ])
        
        
    }
//    @objc
//    func getAllSubjects(sender:UIButton){
//        let subjects = CoreDataManager.shared.getAllSubjects()
//        for subject in subjects ?? [] {
//            print(subject.title ?? "nothing")
//        }
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAllSubjects()
        tableView.reloadData()
    }
    
    
}


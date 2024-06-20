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
        v.separatorColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.systemBackground
        v.dataSource = self
        v.delegate = self
        v.register(SubjectTableViewCell.self, forCellReuseIdentifier: "SubjectCell")
        v.estimatedRowHeight = 600
        v.rowHeight = UITableView.automaticDimension
        return v
    }()

    
    let viewModel = SubjectListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        title = "Subjects"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        
        view.addSubview(tableView)
        setupConstraints()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAllSubjects()
        tableView.reloadData()
    }
}


//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 5/26/24.
//

import UIKit
import CoreData

class SubjectListViewController: UIViewController, AddNewSubjectToSubjectListViewControllerDelegate, UpdateTopicAndMapCountInSubjectCollectionViewDelegate {
  
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout{sectionIndex, enviroment in
            return self.subjectSet()
        }
        
        
        let v = UICollectionView(frame:.zero, collectionViewLayout: layout)
        v.translatesAutoresizingMaskIntoConstraints = false
        v.register(SubejctListViewCell.self, forCellWithReuseIdentifier: "subjectCell")
        v.delegate = self
        v.dataSource = self
        v.isScrollEnabled = true
        return v
    }()
    let viewModel = SubjectListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        title = "Subjects"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
        view.addSubview(collectionView)
        setupConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAllSubjects()
    }
    
}
extension SubjectListViewController{
    
    @objc
    private func addNewSubject(){
        let vc = AddNewSubjectViewController()
        vc.addNewSubjectToSubjectListViewControllerDelegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
   
}
extension SubjectListViewController{
    func subjectSet() -> NSCollectionLayoutSection{
        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fc])
       
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10 // This adds vertical spacing between cells
        //section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
        
        
    }
    func createOptionsBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addNewSubject))

    }
    func didAddSubjectToList() {
        viewModel.getAllSubjects()
        let newIndex = IndexPath(row: viewModel.numberOfSubjects-1, section: 0)
        DispatchQueue.main.async {
            self.collectionView.performBatchUpdates({
                self.collectionView.insertItems(at: [newIndex])
            },completion: {finished in
                if finished{
                    DispatchQueue.main.async {
                        self.collectionView.scrollToItem(at: newIndex, at: .bottom, animated: true)
                    }
                }
            })
        }
        
    }
    func didUpdateTopicMapCountInSubjectCollectionViewFromTopicMapViewController(subjectIndexPath:IndexPath) {

        DispatchQueue.main.async{
            self.collectionView.performBatchUpdates({
                self.collectionView.reloadItems(at: [subjectIndexPath])
            })
        }
    }
    
    
    
}

    
    //    let viewModel = SubjectListViewModel()
    //
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        print("loaded")
    //        title = "Subjects"
    //        navigationController?.navigationBar.prefersLargeTitles = true
    //        navigationItem.rightBarButtonItem = UIBarButtonItem(
    //            barButtonSystemItem: .add,
    //            target: self,
    //            action: #selector(addNewTask))
    //
    //        view.addSubview(tableView)
    //        setupConstraints()
    //    }
    
//    lazy var tableView: UITableView = {
//       let v = UITableView()
//        v.separatorColor = UIColor.clear
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.backgroundColor = UIColor.systemBackground
//        v.dataSource = self
//        v.delegate = self
//        v.register(SubjectTableViewCell.self, forCellReuseIdentifier: "SubjectCell")
//        v.estimatedRowHeight = 600
//        v.rowHeight = UITableView.automaticDimension
//        return v
//    }()
//
//    
//    let viewModel = SubjectListViewModel()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("loaded")
//        title = "Subjects"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .add,
//            target: self,
//            action: #selector(addNewTask))
//        
//        view.addSubview(tableView)
//        setupConstraints()
//    }
//}
//


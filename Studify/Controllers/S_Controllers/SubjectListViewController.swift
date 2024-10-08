//
//  ViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 5/26/24.
//

import UIKit
import CoreData

//class SubjectListViewController: UIViewController, AddNewSubjectToSubjectListViewControllerDelegate, UpdateTopicAndMapCountInSubjectCollectionViewDelegate {
//  
//    
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewCompositionalLayout{sectionIndex, enviroment in
//            return self.subjectSet()
//        }
//        
//        
//        let v = UICollectionView(frame:.zero, collectionViewLayout: layout)
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.register(SubejctListViewCell.self, forCellWithReuseIdentifier: "subjectCell")
//        v.delegate = self
//        v.dataSource = self
//        v.isScrollEnabled = true
//        v.backgroundColor = .clear
//        return v
//    }()
//    let viewModel = SubjectListViewModel()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: .themeDidChange, object: nil)
//        view.backgroundColor = viewModel.background
//        print("loaded")
//        title = "Subjects"
//
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewModel.fontColor,
//                                                                   .font:viewModel.subtitleFont
//                                                                    ]
//        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewModel.fontColor,
//                                                                        .font: viewModel.titleFont]
//
//        navigationController?.navigationBar.barTintColor = viewModel.background
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        
//        
//        
//        navigationItem.rightBarButtonItem = createOptionsBarButtonItem()
//        navigationItem.leftBarButtonItem = createSettingsBarButtonItem()
//        view.addSubview(collectionView)
//        setupConstraints()
//    }
//    deinit {
//          NotificationCenter.default.removeObserver(self)
//      }
//    
//    //TODO: we dont need this, but im not ready to face the consequences of deleting it just yet.
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        viewModel.getAllSubjects()
//    }
//    
//}
//extension SubjectListViewController{
//    
// 
//    
//    private func setupConstraints(){
//        NSLayoutConstraint.activate([
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
//    }
//    
//   
//}
//extension SubjectListViewController{
//    func createOptionsBarButtonItem() -> UIBarButtonItem {
//        return UIBarButtonItem(image: UIImage(systemName: "folder.badge.plus"), style: .plain, target: self, action: #selector(addNewSubject))
//
//    }
//    
//    func createSettingsBarButtonItem() -> UIBarButtonItem{
//        return UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(pushSettingsVc))
// 
//    }
//    
//    @objc
//    private func addNewSubject(){
//        let vc = AddNewSubjectViewController()
//        vc.addNewSubjectToSubjectListViewControllerDelegate = self
//        let navigationController = UINavigationController(rootViewController: vc)
//        vc.view.backgroundColor = viewModel.background
//        print("add New Subject clicked")
//        
//
//      //  navigationController.modalPresentationStyle = .fullScreen
//       // navigationController.navigationBar.backgroundColor = viewmodel.background
//        present(navigationController, animated: true)
//        
//        //navigationController?.pushViewController(vc, animated: true)
//    }
//    
//    @objc
//    private func pushSettingsVc(){
//        let vc = SettingsViewController()
//        navigationController?.pushViewController(vc, animated: true)
//    
//    }
//    @objc
//    func applyTheme(){
//        view.backgroundColor = viewModel.background
//        collectionView.reloadSections(IndexSet(integer: 0))
//        
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: viewModel.fontColor,
//                                                                   .font: viewModel.subtitleFont  ]
//        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: viewModel.fontColor,
//                                                                        .font:viewModel.titleFont    ]
//        navigationController?.navigationBar.barTintColor = viewModel.background
//    }
//}
//
//
//
//extension SubjectListViewController{
//    func subjectSet() -> NSCollectionLayoutSection{
//        let fcSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//        let fc = NSCollectionLayoutItem(layoutSize: fcSize)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.15))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [fc])
//       
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10 // This adds vertical spacing between cells
//        //section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
//        return section
//        
//        
//    }
//
//    
//    func didAddSubjectToList() {
//        viewModel.getAllSubjects()
//        let newIndex = IndexPath(row: viewModel.numberOfSubjects-1, section: 0)
//        DispatchQueue.main.async {
//            self.collectionView.performBatchUpdates({
//                self.collectionView.insertItems(at: [newIndex])
//            },completion: {finished in
//                if finished{
//                    DispatchQueue.main.async {
//                        self.collectionView.scrollToItem(at: newIndex, at: .bottom, animated: true)
//                    }
//                }
//            })
//        }
//        
//    }
//    func didUpdateTopicMapCountInSubjectCollectionViewFromTopicMapViewController(subjectIndexPath:IndexPath) {
//
//        DispatchQueue.main.async{
//            self.collectionView.performBatchUpdates({
//                self.collectionView.reloadItems(at: [subjectIndexPath])
//            })
//        }
//    }
//    
//    
//    
//}

    
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


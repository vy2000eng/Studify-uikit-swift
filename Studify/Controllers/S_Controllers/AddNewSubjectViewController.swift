//
//  AddNewSubjectViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import UIKit

//protocol AddNewSubjectToSubjectListViewControllerDelegate:AnyObject{
//    func didAddSubjectToList()
//}
//
//
//
//class AddNewSubjectViewController: UIViewController {
//    
//    lazy var SubjectNameLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    lazy var textField: UITextField = {
//        let textField = UITextField()
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.borderStyle = .roundedRect
//        textField.layer.borderWidth = 1
//        textField.layer.cornerRadius = 2
//        return textField
//        
//    }()
//    weak var addNewSubjectToSubjectListViewControllerDelegate : AddNewSubjectToSubjectListViewControllerDelegate?
//    
//    let viewModel = AddNewSubjectViewModel()
//    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//        setupSaveButton()
//        setupCloseButton()
//    }
//}
//
//extension AddNewSubjectViewController{
//    
//    private func setupView(){
//        view.backgroundColor = viewModel.currentTheme.backGroundColor
//        textField.textColor = viewModel.currentTheme.fontColor
//        textField.font = viewModel.font
//
//        textField.attributedPlaceholder = NSAttributedString(string: "Enter Subject Title", attributes: [.font: viewModel.font,
//                                                                                                         .foregroundColor:viewModel.fontColor.withAlphaComponent(0.5)
//                                                                                                        ])
//        textField.backgroundColor = viewModel.currentTheme.backGroundColor
//        textField.layer.borderColor = viewModel.currentTheme.backGroundColor == .black ? UIColor.white.withAlphaComponent(0.5).cgColor : UIColor.black.withAlphaComponent(0.5).cgColor
//        SubjectNameLabel.attributedText = NSAttributedString(string: "Subject Name",
//                                                           attributes: [.foregroundColor: viewModel.fontColor,
//                                                                        .font: viewModel.titleFont])
//      
//        title = "Add new subject"
//        
//        if let navigationBar = navigationController?.navigationBar {
//            navigationBar.prefersLargeTitles = false // If you want a standard size title
//            navigationBar.titleTextAttributes = [
//                .foregroundColor: viewModel.fontColor,
//                .font: viewModel.titleFont
//            ]
//        }
//
//        
//        [SubjectNameLabel, textField]
//            .forEach{
//                subViewToAdd in view.addSubview(subViewToAdd)
//            }
//        setupConstraints()
//    }
//    
//    private func setupConstraints(){
//        NSLayoutConstraint.activate([
//            
//            SubjectNameLabel.topAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.topAnchor,
//                constant: 8),
//            SubjectNameLabel.leadingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
//                constant: 16),
//            SubjectNameLabel.trailingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                constant: -16),
//            
//            textField
//                .topAnchor.constraint(
//                equalTo: SubjectNameLabel.bottomAnchor,
//                constant: 8),
//            textField
//                .leadingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
//                constant: 16),
//            textField
//                .trailingAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
//                constant: -16),
//        ])
//    }
//    
//    @objc
//    private func saveSubject(){
//        guard let subjectName = textField.text, !subjectName.isEmpty
//        else{
//            let alert = UIAlertController(
//                title: "Error",
//                message: "Subject Name can't be empty",
//                preferredStyle: .alert)
//            alert.addAction(
//                UIAlertAction(
//                    title: "Ok",
//                    style: .default))
//            present(alert, animated: true)
//            return
//        }
//        
//        
//        
//        
//        
//        let createdOn = Date()
//        viewModel.addSubject(title: subjectName, createdOn: createdOn)
//        addNewSubjectToSubjectListViewControllerDelegate?.didAddSubjectToList()
//        closeViewController()
//    }
//    @objc
//    private func closeViewController() {
//        dismiss(animated: true, completion: nil)
//    }
//}
//
//extension AddNewSubjectViewController{
//    private func setupCloseButton() {
//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            barButtonSystemItem: .close,
//            target: self,
//            action: #selector(closeViewController))
//    }
//    
//    private func setupSaveButton(){
//        navigationItem.rightBarButtonItem =
//        UIBarButtonItem(
//            barButtonSystemItem: .save,
//            target: self,
//            action: #selector(saveSubject))
//        
//    }
//}

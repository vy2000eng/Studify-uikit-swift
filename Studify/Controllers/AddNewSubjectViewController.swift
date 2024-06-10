//
//  AddNewSubjectViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import UIKit

class AddNewSubjectViewController: UIViewController {
    
    
    
    lazy var SubjectNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subject Name"
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter a subject title"
        textField.borderStyle = .roundedRect
        return textField
        
    }()
    
    let viewModel = AddNewSubjectViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    


}

extension AddNewSubjectViewController{
    
    private func setupView(){
        view.backgroundColor = UIColor.systemBackground
        title = "Add new subject"
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveSubject))
        [SubjectNameLabel, textField]
            .forEach{
                subViewToAdd in view.addSubview(subViewToAdd)
            }
        setupConstraints()
        
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            SubjectNameLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            SubjectNameLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16),
            SubjectNameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16),
            
            textField
                .topAnchor.constraint(
                equalTo: SubjectNameLabel.bottomAnchor,
                constant: 8),
            textField
                .leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16),
            textField
                .trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16),
        ])
    }
    
    @objc
    private func saveSubject(){
        guard let subjectName = textField.text, !subjectName.isEmpty
        else{
            let alert = UIAlertController(
                title: "Error",
                message: "Subject Name can't be empty",
                preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .default))
            present(alert, animated: true)
            return
        }
        let createdOn = Date()
        viewModel.addSubject(title: subjectName, createdOn: createdOn)
        navigationController?.popViewController(animated: true)
        
    }
}

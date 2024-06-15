//
//  AddNewTopicViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import UIKit

protocol AddNewTopicViewControllerDelgate: AnyObject{
    func didUpdateTopic()
}

class AddNewTopicViewController: UIViewController {
    
    weak var delegate: AddNewTopicViewControllerDelgate?
    let subjectID : UUID
    let viewModel: AddNewTopicViewModel
    
    init(subjectID: UUID) {
        self.subjectID = subjectID
        self.viewModel = AddNewTopicViewModel(subjectId: subjectID)
        super.init(nibName: nil, bundle: nil)


    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var TopicNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "topic name"
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "enter a topic title"
        textField.borderStyle = .roundedRect
        return textField
        
    }()
    
    //let viewodel = AddNewTopicViewModel(subjectId: subjectID)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension AddNewTopicViewController{
    
    private func setupView(){
        view.backgroundColor = UIColor.systemBackground
        title = "Add new topic"
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveTopic))
        
        [TopicNameLabel, textField]
            .forEach{
                subViewToAdd in view.addSubview(subViewToAdd)
            }
        setupConstraints()
        
        
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            TopicNameLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            TopicNameLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16),
            TopicNameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16),
            
            textField
                .topAnchor.constraint(
                equalTo: TopicNameLabel.bottomAnchor,
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
    private func saveTopic(){
        guard let topicName = textField.text, !topicName.isEmpty
        else{
            let alert = UIAlertController(
                title: "Error",
                message: "Topic title can't be empty",
                preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(
                    title: "Ok",
                    style: .default))
            present(alert, animated: true)
            return
        }
        //let createdOn = Date()
        viewModel.addTopic(title: topicName)
        //viewmodel.addTopic(title: topicName)
        //viewModel.addT(title: subjectName, createdOn: createdOn)
        updateSectionInTopicMapViewController()
        navigationController?.popViewController(animated: true)
        
    }
    
    func updateSectionInTopicMapViewController(){
        print("didUpdate Called")
        delegate?.didUpdateTopic()
    }
}

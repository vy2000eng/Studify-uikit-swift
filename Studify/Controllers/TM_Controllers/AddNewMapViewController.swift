//
//  AddNewMapViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/7/24.
//

import Foundation
import UIKit


protocol AddNewMapViewControllerDelgate: AnyObject{
    func didUpdateMap()
}

class AddNewMapViewController: UIViewController{

    let subjectID: UUID
    let viewModel: AddNewMapViewModel
    weak var delegate: AddNewMapViewControllerDelgate?

    
    init(subjectID: UUID) {
        self.subjectID = subjectID
        self.viewModel = AddNewMapViewModel(subjectID: subjectID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var MapNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       // label.text = "map name"
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        //textField.placeholder = "enter a map title"
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 2
        return textField
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

extension AddNewMapViewController{
    private func setup(){
        view.backgroundColor = viewModel.currentTheme.backGroundColor
       // title = "Add new topic"
        textField.textColor = viewModel.currentTheme.fontColor
        textField.font = viewModel.font
        textField.attributedPlaceholder = NSAttributedString(string: "Enter Map Title", attributes: [.font: viewModel.font,
                                                                                                         .foregroundColor:viewModel.fontColor.withAlphaComponent(0.5)
                                                                                                        ])
        textField.backgroundColor = viewModel.currentTheme.backGroundColor
        textField.layer.borderColor = viewModel.currentTheme.backGroundColor == .black ? UIColor.white.withAlphaComponent(0.5).cgColor : UIColor.black.withAlphaComponent(0.5).cgColor
       // MapNameLabel.textColor = viewModel.currentTheme.fontColor
        MapNameLabel.attributedText = NSAttributedString(string: "Map Name",
                                                         attributes: [.foregroundColor: viewModel.fontColor,
                                                                      .font: viewModel.titleFont])
        
        
      
        title = "Add New Map"
        
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.prefersLargeTitles = false // If you want a standard size title
            navigationBar.titleTextAttributes = [
                .foregroundColor: viewModel.fontColor,
                .font: viewModel.titleFont
            ]
        }
        
        setupAddButton()
        setupCloseButton()
        
        [MapNameLabel, textField].forEach{subviewToAdd in view.addSubview(subviewToAdd)}
        setupConstraints()
        
    }
    
    private func setupConstraints(){
        
        
        NSLayoutConstraint.activate([
            MapNameLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 8),
            MapNameLabel.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 16),
            MapNameLabel.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -16),
            
            textField
                .topAnchor.constraint(
                equalTo: MapNameLabel.bottomAnchor,
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
    private func setupCloseButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeViewController))
    }

    private func setupAddButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
         barButtonSystemItem: .save,
            target: self,
            action: #selector(saveMap))
    }
    
    @objc
    private func closeViewController() {
        dismiss(animated: true, completion: nil)
    }
    @objc
    
    private func saveMap(){
        guard let mapTitle = textField.text, !mapTitle.isEmpty
        else{
            let alert = UIAlertController(title: "Error", message: "Map title can't be empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        viewModel.addMap(title: mapTitle)
        updateSectionInTopicMapViewController()
        dismiss(animated: true, completion: nil)
    }
    
    func updateSectionInTopicMapViewController(){
        print("didUpdate Map called")
        delegate?.didUpdateMap()
    }
    
    
}

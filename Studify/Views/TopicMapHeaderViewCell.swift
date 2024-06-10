//
//  TopicMapHeaderViewCell.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/9/24.
//

import Foundation

import UIKit

class TopicMapHeaderViewCell: UITableViewCell{
    
   // let viewmodel: TopicMapViewModel
    
//
//    let headerView = UIView()
//    headerView.backgroundColor = UIColor.systemBackground  // Customize as needed
    lazy var headerView: UIView = {
       let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    
    
//    // Label for the title
//    let label = UILabel()
//    label.text = sectionTitles[section]
//    label.translatesAutoresizingMaskIntoConstraints = false
//    headerView.addSubview(label)
    lazy var sectionTitle: UILabel = {
       let v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    

    
    lazy var collapseButton: UIButton = {
       let cButton = UIButton()
       let collapseImage = UIImage(systemName: "ellipsis")
        cButton.setImage(collapseImage, for: .normal)
        cButton.translatesAutoresizingMaskIntoConstraints = false
        return cButton
    }()
    
    lazy var addButton: UIButton = {
       let addButton = UIButton()
       let plusImage = UIImage(systemName: "plus")  // Using system image
        addButton.setImage(plusImage, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
      //  addButton.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
        return addButton
    }()
    
    
//
//   // button.setTitle("Add", for: .normal)  // Customize your button title here
//    button.addTarget(self, action: #selector(handleAddButton(_:)), for: .touchUpInside)
//    button.translatesAutoresizingMaskIntoConstraints = false
//    button.tag = section  // Tag button with section index to identify in the action
//    
//    collapseButton.addTarget(self, action: #selector(handleCollapseButton(_:)), for: .touchUpInside)
//    collapseButton.translatesAutoresizingMaskIntoConstraints = false
//    collapseButton.tag = section
//    
//    headerView.addSubview(button)
//    headerView.addSubview(collapseButton)
//
//    // Constraints for the label
//    NSLayoutConstraint.activate([
//        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
//        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//    ])
//
//    // Constraints for the button
//    NSLayoutConstraint.activate([
//        collapseButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
//        collapseButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
//        button.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor,constant: -20),
//        button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
//    ])
//
//    return headerView
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopicMapHeaderViewCell{
    private func setup(){
        contentView.addSubview(headerView)
        headerView.addSubview(sectionTitle)
        headerView.addSubview(collapseButton)
        headerView.addSubview(addButton)
        setupMainConstraints()
    }
    
    private func setupMainConstraints(){
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            sectionTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            sectionTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            collapseButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            collapseButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor,constant: -20),
            addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
    }
    
    func configureTopicHeader(topic: TopicViewModel){
        sectionTitle.text = topic.title
        
    }
}

extension TopicMapHeaderViewCell{
    
//    @objc func handleAddButton(_ sender: UIButton) {
//        let section = sender.tag
        
//        if section == 0{
//            let vc = AddNewTopicViewController(subjectID: viewmodel.subjectID)
//            navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let vc = AddNewMapViewController(subjectID: viewmodel.subjectID)
//            navigationController?.pushViewController(vc, animated: true)
//
//        }
    
    
}

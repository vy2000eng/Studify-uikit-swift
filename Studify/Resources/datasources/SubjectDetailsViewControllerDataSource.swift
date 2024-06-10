//
//  SubjectListViewController.swift
//  Studify
//
//  Created by VladyslavYatsuta on 6/3/24.
//

import UIKit

extension SubjectListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }

    //actually setting up view
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as? SubjectTableViewCell
        else{
            return UITableViewCell()
        }
        let subject = viewModel.subject(by: indexPath.row)
        cell.configure(with: subject)

        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.layer.masksToBounds = true
//       // let radius = cell.contentView.layer.cornerRadius
//        //cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
//    }

    
    

}

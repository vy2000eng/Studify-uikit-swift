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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectCell", for: indexPath) as? SubjectTableViewCell
        else{
            return UITableViewCell()
        }
        let subject = viewModel.subject(by: indexPath.row)
        cell.configure(with: subject)

        return cell
        
    }


    
    

}

//
//  SettingsViewController.swift
//  Mines
//
//  Created by Andrey Zonov on 28/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

protocol SettingsControllerDelegate: class {
    func didSelectConfiguration()
}

class SettingsViewController: UITableViewController {
    
    weak var delegate: SettingsControllerDelegate?
    
    private let cases = Difficulty.allCases
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = cases.index(of: Difficulty.selected) {
            tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: .none)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let configurationCase = cases[indexPath.row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "case")
        cell.textLabel?.text = "\(configurationCase.rawValue)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Difficulty.selected = cases[indexPath.row]
        delegate?.didSelectConfiguration()
    }
}

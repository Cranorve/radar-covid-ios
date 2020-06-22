//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = ["1. Objeto","2. Derechos de propiedad"]
    
    private let tableViewData = [
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"]
    ]
    
    @IBAction func onClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        let textFieldCell = UINib(nibName: "TextTableViewCell",bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: "CELL")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        if let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as? TextTableViewCell {
//            cell.set(content: self.tableViewData[indexPath.section][indexPath.row])
//            return cell
//        }
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionButton = UIButton()
        sectionButton.setTitle(tableHeaders[section], for: .normal)
        sectionButton.backgroundColor = .systemBlue
        sectionButton.tag = section
        sectionButton.addTarget(self, action: #selector(self.hideSection(sender:)), for: .touchUpInside)
        return sectionButton
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(section),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(section),
                                      with: .fade)
        }
    }
    
    private func indexPathsForSection(_ section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<self.tableViewData[section].count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }


}

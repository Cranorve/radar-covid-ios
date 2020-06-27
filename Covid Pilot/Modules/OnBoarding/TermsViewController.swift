//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = ["1. Objeto","2. Derechos de propiedad", "3. Política de privacidad", "4. Excepteur sint occasionecat", "5. Duis aute irure dolor", "6. Laboris nisi ut aliquip ex"]
    
    private let tableViewData = [
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"],
        ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nDuis aute irure dolor in reprehenderit in volup Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occasionecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"]
        
    ]
    
    @IBAction func onClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
        setAllSectionsHidden()
    }
    
    private func setAllSectionsHidden() {
        for i  in 1..<self.tableViewData.count {
            hiddenSections.insert(i)
        }
    }
    
    private func registerTableViewCells() {
        tableView.register(TableHeaderView.self, forHeaderFooterViewReuseIdentifier: "header")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.tableViewData[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont(name: "Muli-Light", size: 20.0)
        cell.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.976000011, blue: 0.9689999819, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return self.tableViewData[section].count
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! TableHeaderView
        view.title = tableHeaders[section]
        view.expanded = !hiddenSections.contains(section)
        view.delegate = self
        view.section = section
        tableViewHeight.constant = calculateHeight()
        return view
    }
    
    func toggle(section: Int?) {
        if let section = section {
            if self.hiddenSections.contains(section) {
                self.hiddenSections.remove(section)
//                self.tableView.insertRows(at: indexPathsForSection(section), with: .none)
            } else {
                self.hiddenSections.insert(section)
//                self.tableView.deleteRows(at: indexPathsForSection(section), with: .none)
               
            }
        }
        tableView.reloadData()
        tableViewHeight.constant = calculateHeight()
    }
    
    private func indexPathsForSection(_ section: Int) -> [IndexPath] {
        var indexPaths = [IndexPath]()
        
        for row in 0..<self.tableViewData[section].count {
            indexPaths.append(IndexPath(row: row,
                                        section: section))
        }
        
        return indexPaths
    }
    
    private func calculateHeight() -> CGFloat {
//        return 30 * CGFloat(tableHeaders.count)
       
        tableView.layoutIfNeeded()

        return tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top
    }


}

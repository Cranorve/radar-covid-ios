//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 21/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ExpandDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var privacyPolicyHeader: UILabel!
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = [
        "1. ¿Qué es Radar COVID?",
        "2. ¿Cómo funciona la aplicación?",
        "3. ¿Qué datos tratamos sobre ti?",
        "4. ¿Cómo obtenemos y de dónde proceden tus datos?",
        "5. ¿Para qué y por qué utilizamos tus datos?",
        "6. ¿Durante cuánto tiempo conservamos tus datos?",
        "7. ¿Quién tiene acceso a tus datos?",
        "8. ¿Cuáles son tus derechos y cómo puedes controlar tus datos?",
        "9. ¿Cómo protegemos tus datos?",
        "10. ¿Cuál es la legitimación para el tratamiento de tus datos?",
        "11. ¿Qué tienes que tener especialmente en cuenta al utilizar \"Radar COVID\"?",
        "12. Política de cookies"
    ]
    
   
    private var strings = Strings()
    private var tableViewData: [String]!
    

    
    @IBAction func onClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewData = strings.privacyPolicy.paragraphs
        tableView.delegate = self
        tableView.dataSource = self
        self.privacyPolicyHeader.attributedText = formatHtmlString(string: strings.privacyPolicy.header.htmlToAttributedString)
        registerTableViewCells()
        setAllSectionsHidden()
    }
    func formatHtmlString(string: NSAttributedString?) -> NSMutableAttributedString {
        let attributedString = string ?? NSAttributedString()
        return NSMutableAttributedString(attributedString: attributedString).setBaseFont(baseFont: UIFont(name:"Muli", size:20.0)!, preserveFontSizes: false)
    }
    
    private func setAllSectionsHidden() {
        for i  in 0..<self.tableViewData.count {
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
        cell.textLabel?.attributedText = formatHtmlString(string: self.tableViewData[indexPath.section].htmlToAttributedString)
        cell.textLabel?.numberOfLines = 0
//        cell.textLabel?.font = UIFont(name: "Muli-Light", size: 20.0)
        cell.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.976000011, blue: 0.9689999819, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let label = UILabel()
//        label.font = UIFont(name: "Muli-Bold",  size: 20.0)
//        label.numberOfLines = 0
//        label.text = tableHeaders[section]
//        label.sizeToFit()
//        return label
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

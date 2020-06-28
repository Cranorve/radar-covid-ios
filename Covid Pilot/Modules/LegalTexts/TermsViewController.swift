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
    @IBOutlet weak var termsHeader: UILabel!
    private var strings = Strings()
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    private var hiddenSections = Set<Int>()
    
    private var tableHeaders = [
        "1.  Qué es Radar COVID",
        "2.  Uso de Radar COVID",
        "3. Seguridad y privacidad",
        "4. Cambio del servicio y terminación",
        "5. Propiedad intelectual e industrial",
        "6. Responsabilidad y obligaciones",
        "7.  Enlaces",
        "8.  Hiperenlaces",
        "9.  Ley aplicable y fuero",
        "10. Información corporativa y contacto"
    ]
    
    private var tableViewData: [String]!

    
    @IBAction func onClose(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        self.termsHeader.attributedText = formatHtmlString(string:  strings.terms.header.htmlToAttributedString)
        super.viewDidLoad()
        self.tableViewData = strings.terms.paragraphs
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
        setAllSectionsHidden()
    }
    
    func formatHtmlString(string: NSAttributedString?) -> NSMutableAttributedString {
        let attributedString = string ?? NSAttributedString()
        return NSMutableAttributedString(attributedString: attributedString).setBaseFont(baseFont: UIFont(name:"Muli", size:20.0)!, preserveFontSizes: false)
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
        cell.textLabel?.attributedText = self.formatHtmlString(string: self.tableViewData[indexPath.section].htmlToAttributedString)
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = #colorLiteral(red: 0.9800000191, green: 0.976000011, blue: 0.9689999819, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return 1
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
            indexPaths.append(IndexPath(row: row, section: section))
        }
        
        return indexPaths
    }
    
    private func calculateHeight() -> CGFloat {
//        return 30 * CGFloat(tableHeaders.count)
       
        tableView.layoutIfNeeded()

        return tableView.contentSize.height + tableView.contentInset.bottom + tableView.contentInset.top
    }


}

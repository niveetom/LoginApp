//
//  TableViewController.swift
//  LoginApp
//
//  Created by Nivedhitha Parthasarathy on 07/08/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

var sectionArr = ["Section 0", "Section 1", "Section 2", "Section 3", "Section 4"]
var rowDict = [0,0,0,0,0]

protocol TableViewHeaderDelegate : class {
    func didChangeHeaderSwitchState(_ sender: CustomHeader, isOn: Bool)
}

class CustomHeader: UITableViewHeaderFooterView {
    
    static let reuseIdentifer = "CustomHeaderReuseIdentifier"
    let lblSection = UILabel.init()
    let btnSwitchSelector = UISwitch.init()
    weak var headerDelegate: TableViewHeaderDelegate?
    
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        btnSwitchSelector.addTarget(self, action: #selector(headerSwitchClicked(_:)), for: .valueChanged)
        
        self.contentView.addSubview(lblSection)
        lblSection.translatesAutoresizingMaskIntoConstraints = false
        lblSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        lblSection.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lblSection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.contentView.addSubview(btnSwitchSelector)
        btnSwitchSelector.translatesAutoresizingMaskIntoConstraints = false
        btnSwitchSelector.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
        btnSwitchSelector.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        btnSwitchSelector.heightAnchor.constraint(equalToConstant: 20).isActive = true
        btnSwitchSelector.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func headerSwitchClicked(_ sender: UISwitch){
        self.headerDelegate?.didChangeHeaderSwitchState(self, isOn:btnSwitchSelector.isOn)
    }
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate, TableViewHeaderDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var selectedRows:[[IndexPath]] = [[],[],[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: CustomHeader.reuseIdentifer)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeader.reuseIdentifer) as? CustomHeader else {
            return nil
        }
        header.contentView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.6588235294, blue: 0.1882352941, alpha: 1)
        header.btnSwitchSelector.tag = section
        header.tag = section
        header.lblSection.text =  sectionArr[section]
        header.btnSwitchSelector.isHidden = false
        if rowDict[section] == 0{
            header.btnSwitchSelector.isHidden = true
        }
        header.lblSection.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        header.headerDelegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowDict[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! TableViewCell
        cell.lblName.text = "Row \(indexPath.row)"
        cell.btnSwitch.setOn(false, animated: true)
        if selectedRows[indexPath.section].contains(indexPath) {
            cell.btnSwitch.setOn(true, animated: true)
        }
        cell.cellDelegate = self
        return cell
    }
    
    func getAllIndexPaths(section: Int) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for j in 0..<tableView.numberOfRows(inSection: section) {
            indexPaths.append(IndexPath(row: j, section: section))
        }
        return indexPaths
    }
    
    func didChangeHeaderSwitchState(_ sender: CustomHeader, isOn: Bool) {
        if isOn{
            self.selectedRows[sender.tag] = getAllIndexPaths(section: sender.tag)
            if self.selectedRows[sender.tag] == []{
                sender.btnSwitchSelector.setOn(false, animated: true)
            }
            else{
                sender.btnSwitchSelector.setOn(true, animated: true)
            }
            self.tableView.reloadRows(at: selectedRows[sender.tag], with: .none)
        }
        else{
            self.selectedRows[sender.tag].removeAll()
            sender.btnSwitchSelector.setOn(false, animated: true)
            self.tableView.reloadSections(IndexSet(integer: sender.tag), with: .none)
        }
    }
    
    func didChangeSwitchState(_ sender: TableViewCell, isOn: Bool) {
        let indxPath = self.tableView.indexPath(for: sender)
        if selectedRows[indxPath!.section].contains(indxPath!) {
            selectedRows[indxPath!.section].remove(at: selectedRows[indxPath!.section].index(of: indxPath!)!)
        } else {
            selectedRows[indxPath!.section].append(indxPath!)
        }
        let header = tableView.headerView(forSection: indxPath!.section) as! CustomHeader
        if self.selectedRows[indxPath!.section] == getAllIndexPaths(section: indxPath!.section){
            header.btnSwitchSelector.setOn(true, animated: true)
        }
        if self.selectedRows[indxPath!.section] == []{
            header.btnSwitchSelector.setOn(false, animated: true)
        }
        tableView.reloadRows(at: [indxPath!], with: .automatic)
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

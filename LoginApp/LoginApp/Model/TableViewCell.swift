//
//  TableViewCell.swift
//  LoginApp
//
//  Created by Nivedhitha Parthasarathy on 07/08/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

protocol TableViewCellDelegate : class {
    func didChangeSwitchState(_ sender: TableViewCell, isOn: Bool)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnSwitch: UISwitch!
    
    weak var cellDelegate: TableViewCellDelegate?
    
    @IBAction func handledSwitchChange(sender: UISwitch) {
        self.cellDelegate?.didChangeSwitchState(self, isOn:btnSwitch.isOn)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

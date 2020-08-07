//
//  DropDownViewController.swift
//  LoginApp
//
//  Created by Nivedhitha Parthasarathy on 07/08/20.
//  Copyright © 2020 Nivedhitha Parthasarathy. All rights reserved.
//

import UIKit

class DropDownViewController: UIViewController {

    @IBOutlet weak var indexDropDown: DropDown!
    
    var selectedSection : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexDropDown.optionArray = sectionArr
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexDropDown.didSelect{(selectedText , index ,id) in
            self.selectedSection = index
        }
    }

    @IBAction func click_Add(_ sender: Any) {
        rowDict[selectedSection] += 1
        self.navigationController?.popToRootViewController(animated: true)
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

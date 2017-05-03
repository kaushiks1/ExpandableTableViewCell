//
//  ViewController.swift
//  ExpandableTableViewCell
//
//  Created by Leo on 1/3/17.
//  Copyright © 2017 Leo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func buttonActionGoToExpandableTableView(_ sender: AnyObject) {

        let viewControllerObject = UIStoryboard (name :"ExpandableProductListMenuStoryboard", bundle:nil).instantiateViewController(withIdentifier: "ExpandableProductListMenuViewController") as? ExpandableProductListMenuViewController
        self.navigationController!.pushViewController(viewControllerObject!, animated: true)


    }



}


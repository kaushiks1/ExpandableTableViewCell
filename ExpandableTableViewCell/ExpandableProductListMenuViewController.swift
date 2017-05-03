//
//  ExpandableProductListMenuViewController.swift
//  ExpandableTableViewCell
//
//  Created by Leo on 1/6/17.
//  Copyright © 2017 Leo. All rights reserved.
//

import UIKit

//let INTTABLEVIEW_EXPANDABLEPRODUCTLISTMENU_HEIGHTFOR_HEADER = HT/(568/44)
//let INTTABLEVIEW_EXPANDABLEPRODUCTLISTMENU_HEIGHTFOR_ROW = HT/(568/44)




class ExpandableProductListMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableTableViewHeaderDelegate {

    var arrayData = [[String:Any]]()
    var arraytableViewData = [[String:Any]]()
    var arrayExpandedSectionIndexIntableView = [Int]()
    @IBOutlet weak var tableViewExpandable: UITableView!
//    var isExpanded: Bool?
    var intSelectedSection: Int?






    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrayData.append(["category_name":"Rings","subcategory_list":["Casual Rings","Men's Ring","Designer Rings"],"expandAndCollaps":"+"])
        self.arrayData.append(["category_name":"Earrings","subcategory_list":["Hoops and Huggies","Drops","Studs with stone"],"expandAndCollaps":"+"])
        self.arrayData.append(["category_name":"Pendant","subcategory_list":["Religious","Casual","Rose Gold"],"expandAndCollaps":"+"])


        print(self.arrayData)

        for dictionaryTemp in self.arrayData
        {
            self.arraytableViewData.append(["category_name":dictionaryTemp["category_name"],"expandAndCollaps":dictionaryTemp["expandAndCollaps"]])
        }

        print(self.arraytableViewData);


        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {

//        self.isExpanded = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arraytableViewData.count
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

//        if !isExpanded!
//        {
//            return 0
//        }
        return (((self.arraytableViewData[section]["subcategory_list"] as? [String])?.count) == nil ? 0 : ((self.arraytableViewData[section]["subcategory_list"] as? [String])?.count)!)
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
//
//        cell.textLabel?.text = (self.arraytableViewData[indexPath.section]["subcategory_list"] as? [String])?[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewCell", for: indexPath) as? ExpandableTableViewCell

        cell?.setUpCellData(cellData: ((self.arraytableViewData[indexPath.section]["subcategory_list"] as? [String])? [indexPath.row])!, cellIndex: indexPath.row)


        return cell!
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print(indexPath.section)
        print(indexPath.row)

        let expandableTableViewHeaderObject = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewHeader") as! ExpandableTableViewHeader

        expandableTableViewHeaderObject.delegate = self
        expandableTableViewHeaderObject.setUpHeaderData(headerData: (self.arraytableViewData[indexPath.section]["category_name"] as? [String : Any])!, headerIndex: indexPath.section)

        self.buttonActionExpandAndCollapsFromExpandableTableViewHeader(expandableTableViewHeader : expandableTableViewHeaderObject, headerData: self.arraytableViewData[indexPath.section]["category_name"], indexFromHeader: indexPath.section)
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return sections[indexPath.section].collapsed! ? 0 : 44.0
        return 44.0

    }



    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let expandableTableViewHeaderObject = tableView.dequeueReusableCell(withIdentifier: "ExpandableTableViewHeader") as? ExpandableTableViewHeader

            expandableTableViewHeaderObject?.delegate = self
            expandableTableViewHeaderObject?.setUpHeaderData(headerData: self.arraytableViewData[section], headerIndex: section)

//            header.titleLabel.text = sections[section].name
//            header.arrowLabel.text = ">"
//            header.setCollapsed(collapsed: sections[section].collapsed)
//    
//            header.section = section
    //        header.delegate = self
    
            return expandableTableViewHeaderObject
        }


    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }


    func buttonActionExpandAndCollapsFromExpandableTableViewHeader(expandableTableViewHeader : ExpandableTableViewHeader,headerData: Any, indexFromHeader: Int)
    {
        print(headerData)
        print(indexFromHeader)
        print(expandableTableViewHeader)

        if self.arrayExpandedSectionIndexIntableView.count > 0
        {
            if self.arrayExpandedSectionIndexIntableView.contains(obj: indexFromHeader)
            {
                self.arrayExpandedSectionIndexIntableView.remove(object: indexFromHeader)
                self.arraytableViewData[indexFromHeader].removeValue(forKey: "subcategory_list")
                self.arraytableViewData[indexFromHeader]["expandAndCollaps"] = "+"
            }
            else
            {
                self.arrayExpandedSectionIndexIntableView.append(indexFromHeader)
                self.arraytableViewData[indexFromHeader] = self.arrayData[indexFromHeader]
                self.arraytableViewData[indexFromHeader]["expandAndCollaps"] = "-"
            }
        }
        else
        {
            self.arrayExpandedSectionIndexIntableView.append(indexFromHeader)
            self.arraytableViewData[indexFromHeader] = self.arrayData[indexFromHeader]
            self.arraytableViewData[indexFromHeader]["expandAndCollaps"] = "-"

        }

//        self.isExpanded = true

//        self.tableViewExpandable.beginUpdates()
//
//        self.tableViewExpandable.endUpdates()

       self.tableViewExpandable.reloadData()

//        self.tableViewExpandable.reloadSections(NSIndexSet(index: indexFromHeader), with: .automatic)



//        //to reload your cell data
////        self.tableView.reloadData()
//        DispatchQueue.main.async {
//            // this is needed to update a specific tableview's headerview layout on main queue otherwise it's won't update perfectly cause reloaddata() is called
//            self.tableViewExpandable.beginUpdates()
//            self.tableViewExpandable.endUpdates()
//        }


    }

}

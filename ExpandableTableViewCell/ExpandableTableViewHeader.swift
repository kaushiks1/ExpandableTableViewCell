//
//  ExpandableTableViewHeader.swift
//  ExpandableTableViewCell
//
//  Created by Leo on 1/7/17.
//  Copyright © 2017 Leo. All rights reserved.
//

import UIKit

protocol ExpandableTableViewHeaderDelegate
{
    func buttonActionExpandAndCollapsFromExpandableTableViewHeader(expandableTableViewHeader : ExpandableTableViewHeader, headerData: Any, indexFromHeader: Int)
}

class ExpandableTableViewHeader: UITableViewCell {

    public var delegate: ExpandableTableViewHeaderDelegate?
    var expandableTableViewHeaderData: Any?
    var IntHeaderIndex: Int?


    @IBOutlet weak var labelExpandAndCollaps: UILabel!
    @IBOutlet weak var labelCategoryName: UILabel!




    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    public func setUpHeaderData(headerData: [String:Any], headerIndex: Int)
    {
        print(headerData)

        self.IntHeaderIndex = headerIndex
        self.expandableTableViewHeaderData = headerData

        self.labelCategoryName.text = headerData["category_name"] as? String
        self.labelExpandAndCollaps.text = headerData["expandAndCollaps"] as? String


    }

    
    @IBAction func buttonActionExpandAndCollaps(_ sender: AnyObject) {

        if let delegate = self.delegate
        {
            delegate.buttonActionExpandAndCollapsFromExpandableTableViewHeader(expandableTableViewHeader : self, headerData: self.expandableTableViewHeaderData, indexFromHeader: self.IntHeaderIndex!)
        }
    }


}

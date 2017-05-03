//
//  ExpandableTableViewCell.swift
//  ExpandableTableViewCell
//
//  Created by Leo on 1/9/17.
//  Copyright © 2017 Leo. All rights reserved.
//

import UIKit

class ExpandableTableViewCell: UITableViewCell {

    @IBOutlet weak var labelSubCategoryName: UILabel!






    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


    public func setUpCellData(cellData: String, cellIndex: Int)
    {
        print(cellData)

        self.labelSubCategoryName.text = cellData

    }


    override func prepareForReuse()
    {
        print("Usa")
    }
}

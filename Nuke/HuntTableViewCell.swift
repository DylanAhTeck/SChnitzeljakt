//
//  HuntTableViewCell.swift
//  Nuke iOS
//
//  Created by Harrison Weinerman on 11/28/18.
//  Copyright © 2018 Alexander Grebenyuk. All rights reserved.
//

import UIKit

class HuntTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var huntImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

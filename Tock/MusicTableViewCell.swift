//
//  MusicTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 12/26/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  CustomTableViewCell.swift
//  APIImages
//
//  Created by DA MAC M1 157 on 2023/06/09.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var apiImage: UIImageView!
    @IBOutlet weak var apiLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

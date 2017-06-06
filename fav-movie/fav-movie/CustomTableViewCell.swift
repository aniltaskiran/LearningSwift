//
//  CustomTableViewCell.swift
//  fav-movie
//
//  Created by kev on 6.06.2017.
//  Copyright © 2017 aniltaskiran. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var moiveImageView: UIImageView!
    @IBOutlet var movieTittle: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var favButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

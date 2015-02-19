//
//  TruckTableViewCell.swift
//  Where The Truck
//
//  Created by Brian Doore on 1/13/15.
//  Copyright (c) 2015 Brian Doore. All rights reserved.
//

import UIKit

class TruckTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var truckNameLabel: UILabel!
    @IBOutlet weak var truckDescriptionLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var truckThumbnail: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        

    }
    
    

}

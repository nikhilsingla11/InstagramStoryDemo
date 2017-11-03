//
//  storyTableViewCell.swift
//  InstagramStoryDemo
//
//  Created by Aggarwal, Nikhil on 11/1/17.
//  Copyright © 2017 Aggarwal, Nikhil. All rights reserved.
//

import UIKit

class storyTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

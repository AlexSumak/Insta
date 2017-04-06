//
//  InstaCellTableViewCell.swift
//  instaclient
//
//  Created by  Alex Sumak on 4/1/17.
//  Copyright © 2017  Alex Sumak. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class InstaCellTableViewCell: UITableViewCell {

  @IBOutlet weak var captionStuff: UILabel!
  @IBOutlet weak var photoView: PFImageView!
  
  var instagramPost: PFObject! {
    didSet {
      self.photoView.file = instagramPost["media"] as? PFFile
      self.photoView.loadInBackground()
       self.captionStuff.text = instagramPost["caption"] as? String
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

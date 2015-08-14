//
//  QuoteTableViewCell.swift
//  Qwip
//
//  Created by Anthony Emberley on 4/3/15.
//  Copyright (c) 2015 Qwip. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {
    //var qwip:Qwip
    
    @IBOutlet weak var numberFavorites: UILabel!
    @IBOutlet weak var numberReqwips: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var reqwipButton: UIButton!
    @IBOutlet weak var usernameButton: UIButton!
    @IBAction func usernameButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var quoteTextView: UITextView!
    
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

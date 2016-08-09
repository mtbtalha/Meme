//
//  MemesTableViewCell.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemesTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    static var cellIdentifier = "MemesTableViewCell"
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 30)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    func setupCell(meme: Meme) {
        topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: memeTextAttributes)
        bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeTextAttributes)
        memeImageView.image = meme.originalImage
    }

}

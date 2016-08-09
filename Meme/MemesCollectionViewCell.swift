//
//  MemesCollectionViewCell.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Variables
    
    static var cellIdentifier = "MemesCollectionViewCell"
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 20)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    //MARK: - View Setup
    
    func setupCell(meme: Meme) {
        topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: memeTextAttributes)
        bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: memeTextAttributes)
        imageView.image = meme.originalImage
    }
}

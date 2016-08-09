//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    //MARK: - Variables
    
    var meme: Meme!
    
    //MARK: - View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
        
    }

}

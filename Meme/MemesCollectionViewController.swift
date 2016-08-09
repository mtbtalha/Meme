//
//  MemesCollectionViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: .Plain, target: self, action: #selector(MemesTableViewController.routeToAddMemeVC))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MemesCollectionViewCell.cellIdentifier, forIndexPath: indexPath) as! MemesCollectionViewCell
        cell.setupCell(memes[indexPath.row])
        return cell
    }
    
    func routeToAddMemeVC() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        presentViewController(addMemeVC, animated: true, completion: nil)
    }
}

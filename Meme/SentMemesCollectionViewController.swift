//
//  SentMemesCollectionViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: - Variables
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Sent Memes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(SentMemesCollectionViewController.routeToAddMemeVC))
        
        let space: CGFloat = 3.0
        let widthdimension = ((self.view.frame.size.width) - (2 * space)) / 3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSizeMake(widthdimension, 175.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = false
        collectionView.reloadData()
    }
    
    //MARK: - UICollectionViewDataSource
    
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
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        memeDetailVC.meme = memes[indexPath.row]
        tabBarController?.tabBar.hidden = true
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
    //MARK: - Utilities
    
    func routeToAddMemeVC() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        presentViewController(addMemeVC, animated: true, completion: nil)
    }
}

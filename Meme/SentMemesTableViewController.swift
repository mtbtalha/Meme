//
//  SentMemesTableViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Sent Memes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(SentMemesTableViewController.routeToAddMemeVC))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.hidden = false
        tableView.reloadData()
    }
    
    //MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MemesTableViewCell.cellIdentifier, forIndexPath: indexPath) as! MemesTableViewCell
        cell.setupCell(memes[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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

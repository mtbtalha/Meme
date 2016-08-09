//
//  MemesTableViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/9/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Meme", style: .Plain, target: self, action: #selector(MemesTableViewController.routeToAddMemeVC))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

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
    
    func routeToAddMemeVC() {
        let addMemeVC = storyboard?.instantiateViewControllerWithIdentifier("MemeViewController") as! MemeViewController
        presentViewController(addMemeVC, animated: true, completion: nil)
    }
}

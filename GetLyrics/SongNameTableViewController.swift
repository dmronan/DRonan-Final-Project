//
//  SongNameTableViewController.swift
//  GetLyrics
//
//  Created by Dom Ronan on 4/29/17.
//  Copyright © 2017 Dom Ronan. All rights reserved.
//

import UIKit

class SongNameTableViewController: UITableViewController {
    
    var songsArray = [Song]()
    var song: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.editButtonItem.tintColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ bleView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            songsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
    }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return songsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongNameCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = (songsArray[indexPath.row]).name
        return cell
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let indexPath = tableView.indexPathForSelectedRow!
            let destinationViewController = segue.destination as! DetailViewController
            let selectedSong = songsArray[indexPath.row]
            destinationViewController.songObject = selectedSong
            print("This is \(selectedSong)")
        }
    }
    
    @IBAction func unwindToTableViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SearchViewController, let song = sourceViewController.songObject
        {
            songsArray.append(song)
self.tableView.reloadData()
        }
    }
    
}

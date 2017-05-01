//
//  DetailViewController.swift
//  GetLyrics
//
//  Created by Dom Ronan on 4/29/17.
//  Copyright © 2017 Dom Ronan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    var songObject: Song!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.red

        
        songName.text = songObject.name
        artistName.text = songObject.artist
        lyricsView.text = songObject.lyrics
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


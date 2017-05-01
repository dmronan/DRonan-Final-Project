//
//  SearchViewController.swift
//  GetLyrics
//
//  Created by Dom Ronan on 4/29/17.
//  Copyright © 2017 Dom Ronan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var songTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var songResult: UITextView!
    @IBOutlet weak var artistResult: UITextView!
    @IBOutlet weak var lyricsResult: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var songName: String?
    var artistName: String?
    var q_track: String?
    var q_artist: String?
    var newTrack: String?
    var newArtist: String?

    var songObject: Song!
    
    var songsArray = ["Right Above It",
                      "Perfect Pint",
                      "Go Deep"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func getSong(completed: @escaping () -> ()) {
        
        let songURL = urlBase + newTrack! + "&q_artist=" + newArtist! + APIKey
        
        
        saveButton.isEnabled = true
        
        //        self.newSong = Song.init()
        
        Alamofire.request(songURL).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var song = json["message"]["body"]["track_list"][0]["track"]["track_name"].stringValue
                var artist = json["message"]["body"]["track_list"][0]["track"]["artist_name"].stringValue
                
                self.songResult.text = song
                self.artistResult.text = artist
                
            case .failure(let error):
                self.songResult.text = "Sorry, Song Not Found"
            }
         completed()
        }
    }
    
    func getLyrics(completed: @escaping () -> ()) {
        
        let lyricsURL = urlBaseLyrics + newTrack! + "&q_artist=" + newArtist! + APIKeyLyrics
        print(lyricsURL)
        
        Alamofire.request(lyricsURL).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var lyrics = json["message"]["body"]["lyrics"]["lyrics_body"].stringValue
                print(lyrics)
                
                self.lyricsResult.text = lyrics
                
            case .failure(let error):
                self.lyricsResult.text = "Sorry, Lyrics Not Found"
        
            }
    completed()
        }
    }
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
        q_track = songTextField.text!
        q_artist = artistTextField.text
        newTrack = q_track?.replacingOccurrences(of: " ", with: "%20")
        newArtist = q_artist?.replacingOccurrences(of: " ", with: "%20")
        
        saveButton.isEnabled = true
        view.endEditing(true)
        
        getSong {
            self.getLyrics {
                
                self.songObject = Song(name: self.songResult.text, artist: self.artistResult.text, lyrics: self.lyricsResult.text)
                
            }
        }
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton == sender as! UIBarButtonItem {
            
            songName = songResult.text
        }
    }
}

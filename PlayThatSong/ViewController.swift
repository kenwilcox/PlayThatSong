//
//  ViewController.swift
//  PlayThatSong
//
//  Created by Kenneth Wilcox on 3/29/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var currentSongLabel: UILabel!
  
  var audioSession: AVAudioSession!
  var audioQueuePlayer: AVQueuePlayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureAudioSession()
    self.configureAudioQueuePlayer()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func playButtonPressed(sender: UIButton) {
    self.playMusic()
  }

  @IBAction func playPreviousButtonPressed(sender: UIButton) {
  }
  
  @IBAction func playNextButtonPressed(sender: UIButton) {
    self.audioQueuePlayer.advanceToNextItem()
  }
  
  //MARK: AVFoundation
  func configureAudioSession () {
    var categoryError:NSError?
    var activeError: NSError?

    self.audioSession = AVAudioSession.sharedInstance()
    self.audioSession.setCategory(AVAudioSessionCategoryPlayback, error: &categoryError)
    println("error \(categoryError)")
    var success = self.audioSession.setActive(true, error: &activeError)
    if !success {
      println("Error making audio session active \(activeError)")
    }
  }
  
  func configureAudioQueuePlayer () {
    let songs = createSongs()
    self.audioQueuePlayer = AVQueuePlayer(items: songs)
    for var songIndex = 0; songIndex < songs.count; songIndex++ {
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "songEnded:", name:
        AVPlayerItemDidPlayToEndTimeNotification, object: songs[songIndex])
    }
  }
  
  func playMusic () {
    self.audioQueuePlayer.play()
  }
  
  func createSongs () -> [AnyObject] {
    let solitude = NSBundle.mainBundle().pathForResource("CLASSICAL SOLITUDE", ofType: "wav")
    let doldesh = NSBundle.mainBundle().pathForResource("Timothy Pinkham - The Knolls of Doldesh", ofType: "mp3")
    let signal = NSBundle.mainBundle().pathForResource("Open Source - Sending My Signal", ofType: "mp3")
    
    let songs: [AnyObject] = [
      AVPlayerItem(URL: NSURL.fileURLWithPath(solitude!)),
      AVPlayerItem(URL: NSURL.fileURLWithPath(doldesh!)),
      AVPlayerItem(URL: NSURL.fileURLWithPath(signal!))
    ]
    return songs
  }
}


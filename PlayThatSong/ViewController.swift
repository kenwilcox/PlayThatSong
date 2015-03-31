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
  
  //MARK: Properties
  @IBOutlet weak var playButton: UIButton!
  @IBOutlet weak var currentSongLabel: UILabel!
  
  var audioSession: AVAudioSession!
  var audioQueuePlayer: AVQueuePlayer!
  var currentSongIndex:Int!
  
  //MARK: Overrides
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
  
  // MARK: IBActions
  @IBAction func playButtonPressed(sender: UIButton) {
    self.playMusic()
    self.updateUI()
  }

  @IBAction func playPreviousButtonPressed(sender: UIButton) {
    if currentSongIndex > 0 {
      self.audioQueuePlayer.pause()
      self.audioQueuePlayer.seekToTime(kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
      
      let temporaryNowPlayIndex = currentSongIndex
      let temporaryPlayList = self.createSongs()
      
      self.audioQueuePlayer.removeAllItems()
      for var index = temporaryNowPlayIndex - 1; index < temporaryPlayList.count; index++ {
        self.audioQueuePlayer.insertItem(temporaryPlayList[index] as AVPlayerItem, afterItem: nil)
      }
      
      self.currentSongIndex = temporaryNowPlayIndex - 1
      self.audioQueuePlayer.seekToTime(kCMTimeZero, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
      self.audioQueuePlayer.play()
    }
    self.updateUI()
  }
  
  @IBAction func playNextButtonPressed(sender: UIButton) {
    self.audioQueuePlayer.advanceToNextItem()
    self.currentSongIndex = self.currentSongIndex + 1
    self.updateUI()
  }
  
  //MARK: AVFoundation
  func configureAudioSession() {
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
  
  func configureAudioQueuePlayer() {
    let songs = createSongs()
    self.audioQueuePlayer = AVQueuePlayer(items: songs)
    for var songIndex = 0; songIndex < songs.count; songIndex++ {
      NSNotificationCenter.defaultCenter().addObserver(self, selector: "songEnded:", name:
        AVPlayerItemDidPlayToEndTimeNotification, object: songs[songIndex])
    }
  }
  
  func playMusic() {
    if audioQueuePlayer.rate > 0 && audioQueuePlayer.error == nil {
      self.audioQueuePlayer.pause()
    } else if currentSongIndex == nil {
      self.audioQueuePlayer.play()
      self.currentSongIndex = 0
    } else {
      self.audioQueuePlayer.play()
    }
  }
  
  func createSongs() -> [AnyObject] {
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
  
  //MARK: NSNotifications
  func songEnded(notification: NSNotification) {
    self.currentSongIndex = self.currentSongIndex + 1
    updateUI()
  }
  
  //MARK: Helper functions
  func updateUI() {
    self.currentSongLabel.text = currentSongName()
    if audioQueuePlayer.rate > 0 && audioQueuePlayer.error == nil {
      self.playButton.setTitle("Pause", forState: UIControlState.Normal)
    } else {
      self.playButton.setTitle("Play", forState: UIControlState.Normal)
    }
  }
  
  func currentSongName() -> String {
    var currentSong: String
    if currentSongIndex == 0 {
      currentSong = "Classical Solitude"
    } else if currentSongIndex == 1 {
      currentSong = "The Knolls of Doldesh"
    } else if currentSongIndex == 2 {
      currentSong = "Sending my Signal"
    } else {
      currentSong = "No Song Playing"
      println("Something went wrong!")
    }
    return currentSong
  }
}


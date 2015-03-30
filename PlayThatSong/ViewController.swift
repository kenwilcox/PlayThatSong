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
  var audioPlayer: AVAudioPlayer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.configureAudioSession()
    self.configureAudioPlayer()
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
  
  func configureAudioPlayer () {
    var songPath = NSBundle.mainBundle().pathForResource("Open Source - Sending My Signal", ofType: "mp3")
    var songURL = NSURL.fileURLWithPath(songPath!)
    println("songURL: \(songURL)")
    
    var songError: NSError?
    self.audioPlayer = AVAudioPlayer(contentsOfURL: songURL, error: &songError)
    
    println("song error: \(songError)")
    self.audioPlayer.numberOfLoops = 0
  }
  
  func playMusic () {
    self.audioPlayer.prepareToPlay()
    self.audioPlayer.play()
  }
}


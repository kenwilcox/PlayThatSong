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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func playButtonPressed(sender: UIButton) {
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
}


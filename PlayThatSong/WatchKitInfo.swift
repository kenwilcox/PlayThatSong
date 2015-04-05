//
//  WatchKitInfo.swift
//  PlayThatSong
//
//  Created by Kenneth Wilcox on 4/4/15.
//  Copyright (c) 2015 Kenneth Wilcox. All rights reserved.
//

import Foundation

let key = "FunctionRequestKey"

class WatchKitInfo {
  var replyBlock: ([NSObject : AnyObject]!) -> Void
  var playerRequest: String?
  
  init(playerDictionary: [NSObject: AnyObject], reply: ([NSObject : AnyObject]!) -> Void) {
    
    if let playerDictionary = playerDictionary as? [String : String] {
      playerRequest = playerDictionary[key]
    } else {
      println("No Information Error")
    }
    
    replyBlock = reply
  }
}
 //
//  ViewController.swift
//  inTuned
//
//  Created by Trey Hope on 8/22/15.
//  Copyright (c) 2015 Trey Hope. All rights reserved.
//

import UIKit
import MediaPlayer


class UserController: UIViewController, MPMediaPickerControllerDelegate {
    
    //User's name.
    var userName = String()
    //Number of songs user has in library.
    var numberOfSongs = Int()
    //User's media contoller.
    var mediaController = MediaController()
    
    
    internal func updateUserInfo(index: Int){
        numberOfSongs = mediaController.getNumberOfSongs()
        mediaController.getSongInformation(index)
    }
    

    
    
}


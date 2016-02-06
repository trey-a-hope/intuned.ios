//
//  AlertMessage.swift
//  inTuned
//
//  Created by Trey Hope on 8/28/15.
//  Copyright (c) 2015 Trey Hope. All rights reserved.
//

import UIKit
import Foundation

class AlertMessage {
    let alert = UIAlertView()
    //let numberOfSongs = UserController().mediaController.getNumberOfSongs() - 1
    
    func showError_INCORRECT_TRACK_INDEX(){
        //alert.title = "Track index must be between 0 and " + String(numberOfSongs)
        alert.title = "Track must be in between index."
        alert.addButtonWithTitle("Cool.")
        alert.show()
    }
    
    func showError_EMPTY_TEXT_FIELD(){
        alert.title = "Must input track number"
        alert.addButtonWithTitle("Cool.")
        alert.show()
    }
}

//TODO: Fix "getNumberofSongs() issue that's causing the app to crash when used here.
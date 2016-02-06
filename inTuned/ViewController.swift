//
//  ViewController.swift
//  inTuned
//
//  Created by Trey Hope on 8/22/15.
//  Copyright (c) 2015 Trey Hope. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    
    @IBOutlet weak var indexInput: UITextField!
    @IBOutlet weak var getInfoBtn: UIButton!
    
    var user = UserController();
    var alertMessage = AlertMessage();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getInfoBtn.addTarget(self, action: "getInfo:", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Handles events for application entering background state.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pauseSong:"), name:UIApplicationDidEnterBackgroundNotification, object: nil)
        
        // Handles events for application entering active state.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("playSong:"), name:UIApplicationDidBecomeActiveNotification, object: nil)
        
        getInfoBtn.layer.cornerRadius = 5;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getInfo(sender: UIButton!){
        if(indexInput.text != nil && indexInput.text != ""){
            var index = indexInput.text.toInt()
            if(index <= user.mediaController.getNumberOfSongs() - 1){
                user.updateUserInfo(index!)
                user.mediaController.playSongAtIndex(index!)
                showSongInformation()
            }
            else{
                alertMessage.showError_INCORRECT_TRACK_INDEX()
            }
        }
        else{
            alertMessage.showError_EMPTY_TEXT_FIELD()
        }
    }
    
    func showSongInformation(){
        let alert = UIAlertView()
        alert.title = "Last Played Date: " + user.mediaController.song.lastPlayedDate
        alert.addButtonWithTitle("Cool")
        alert.show()
    }

    func pauseSong(notification : NSNotification) {
        user.mediaController.pauseSong()
    }
    
    func playSong(notification : NSNotification) {
        user.mediaController.playSong()
    }
}


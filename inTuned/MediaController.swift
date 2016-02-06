//
//  MediaController.swift
//  inTuned
//
//  Created by Trey Hope on 8/26/15.
//  Copyright (c) 2015 Trey Hope. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class MediaController: UIViewController, MPMediaPickerControllerDelegate {
    
    let mediaItems = MPMediaQuery.songsQuery().items
    let player = MPMusicPlayerController.systemMusicPlayer()
    var recorder = AVAudioRecorder()
    var song = Song()
    
    internal func playSongAtIndex(index : Int){
        var mediaCollection = MPMediaItemCollection(items: mediaItems)
        player.setQueueWithItemCollection(mediaCollection)
        player.nowPlayingItem = mediaCollection.items[index] as! MPMediaItem
        player.play()
        
        player.currentPlaybackTime = 30
    }
    
    internal func pauseSong(){
        player.pause()
    }
    
    internal func playSong(){
        player.play()
    }
    
    internal func getNumberOfSongs() -> Int{
        var mediaCollection = MPMediaItemCollection(items: mediaItems)
        return mediaCollection.count
    }
    
    internal func getSongInformation(index: Int){
        var mediaCollection = MPMediaItemCollection(items: mediaItems)
        var file = mediaCollection.items[index] as! MPMediaItem
        
        song.file = file
        song.artist = (file.artist != nil) ? file.artist : "No Artist Name"
        song.genre = (file.genre != nil) ? file.genre : "No Genre"
        song.title = (file.title != nil) ? file.title : "No Title"
        song.beatsPerMinute = file.beatsPerMinute
        song.lastPlayedDate = helper_getSongInformation_lastPlayedDate(index)
    }
    
    
        internal func helper_getSongInformation_lastPlayedDate(index: Int) -> String{
            var mediaCollection = MPMediaItemCollection(items: mediaItems)
            var file = mediaCollection.items[index] as! MPMediaItem
            
            var df = NSDateFormatter()
            
            df.dateStyle = NSDateFormatterStyle.MediumStyle
            df.timeStyle = NSDateFormatterStyle.ShortStyle
            
            var date = (file.lastPlayedDate != nil) ? file.lastPlayedDate : NSDate()
            
            return df.stringFromDate(date)
        }
    
    /*   RECORDER METHODS (MAY NOT BE NEEDED)  */
    internal func prepareRecorder(){
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        var currentFileName = "Recording-(" + formatter.stringFromDate(NSDate()) +  ").mp3"
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var docsDir: AnyObject = dirPaths[0]
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName)
        var soundFileURL = NSURL(fileURLWithPath: soundFilePath)
        let filemanager = NSFileManager.defaultManager()
        
        var recordSettings:[NSObject: AnyObject] = [
                    AVFormatIDKey: kAudioFormatAppleLossless,
                    AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
                    AVEncoderBitRateKey : 320000,
                    AVNumberOfChannelsKey: 2,
                    AVSampleRateKey : 44100.0
        ]
        
        var error: NSError?
        
        recorder = AVAudioRecorder(URL: soundFileURL!, settings: recordSettings, error: &error)
        
        recorder.meteringEnabled = true
        recorder.prepareToRecord()
    }
    
}


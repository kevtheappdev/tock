//
//  TockMusicViewController.swift
//  Pods
//
//  Created by Kevin Turner on 12/25/16.
//
//

import UIKit
import MediaPlayer

class TockMusicViewController: UIViewController, MPMediaPickerControllerDelegate {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var albumLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var volumeSlider: UISlider!
    let musicPlayer  = MPMusicPlayerController.applicationMusicPlayer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(TockMusicViewController.hideTutorial), userInfo: nil, repeats: false)
        
        registerNotifications()
        
    }
    
    func registerNotifications(){
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(TockMusicViewController.handleNowPlaying), name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange, object: nil)
              musicPlayer.beginGeneratingPlaybackNotifications()
        
        notificationCenter.addObserver(self, selector: #selector(TockMusicViewController.playbackStateChanged), name: NSNotification.Name.MPMusicPlayerControllerPlaybackStateDidChange, object: nil)
        
    }
    
    func playbackStateChanged(){
        if self.musicPlayer.playbackState == .playing {
            self.playButton.setImage(#imageLiteral(resourceName: "pause2.png"), for: .normal)
        } else if self.musicPlayer.playbackState == .paused {
            self.playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    func handleNowPlaying(){
        let playingItem = self.musicPlayer.nowPlayingItem
        self.titleLabel.text = playingItem?.title
        self.albumLabel.text = playingItem?.albumTitle
        self.artistLabel.text = playingItem?.artist
        self.albumCover.image = playingItem?.artwork?.image(at: albumCover.bounds.size)
    }
    
    @IBAction func volumeChanged(_ sender: Any) {
        
    }
    
    func hideTutorial(){
        UIView.animate(withDuration: 2, animations: {() in
            self.tutorialLabel.alpha = 0
        })
    }

    @IBAction func skipForward(_ sender: Any) {
            self.musicPlayer.skipToNextItem()
    }
    
    @IBAction func skipBackward(_ sender: Any) {
        self.musicPlayer.skipToPreviousItem()
    }
    
    
    @IBAction func doubleTapped(_ sender: Any) {
        let mediaPicker = MPMediaPickerController(mediaTypes: .any)
        mediaPicker.delegate = self
        mediaPicker.allowsPickingMultipleItems = true
        mediaPicker.prompt = "Select songs to play tonight"
        self.show(mediaPicker, sender: self)
    }
    
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            self.musicPlayer.setQueue(with: mediaItemCollection)
            self.play()
            print("picked")
            mediaPicker.dismiss(animated: true, completion:  nil)
    }
    
    
    @IBOutlet weak var skipForwardButtonPressed: UIButton!
    func play(){
        self.playButton.setImage(#imageLiteral(resourceName: "pause2.png"), for: .normal)
        self.musicPlayer.play()
    }
    
    
    @IBAction func playButtonPressed(_ sender: Any) {
        if musicPlayer.playbackState == .paused {
            
            self.musicPlayer.play()
        } else if musicPlayer.playbackState == .playing {
            
            self.musicPlayer.pause()
        }
    }
    
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
        print("cancelled")
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

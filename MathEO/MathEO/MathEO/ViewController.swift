//
//  ViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 04/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum state {
        case orange, yellow
    }
    
    @IBOutlet weak var mainPageView: UIView!
    
    @IBOutlet weak var playButton: UIButton!
    
    var timer : Timer!
    
    var audioPlayer : AVAudioPlayer!
    
    var buttonState = state.orange
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {(timer) in
            if self.buttonState == .orange {
                self.playButton.setBackgroundImage(UIImage(named: "playButton2.jpg"), for: UIControlState.normal)
                self.buttonState = .yellow
            }
            else {
                self.playButton.setBackgroundImage(UIImage(named: "playButton.jpg"), for: UIControlState.normal)
                self.buttonState = .orange
            }
        })
        
        let path: String! = Bundle.main.resourcePath?.appending("/main-page.mp3")
        let mp3URL = URL.init(string: path)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL!)
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
    }
    
    @IBAction func nextPage(_ sender: UIButton) {
        //Disable all working member class.
        audioPlayer.stop()
        timer.invalidate()
        
        //Transition into new ViewController.
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "ChapterStory")
        present(VC, animated: false, completion: nil)
        
        nextView()
    }
    
    //Animate into Next ViewController.
    func nextView() {
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.mainPageView.transform = CGAffineTransform(translationX: -self.mainPageView.bounds.width, y: 0)
            })
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "goToChapter", sender: nil)
        })
    }
}


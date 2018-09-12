//
//  BedroomViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 04/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class BedroomViewController: UIViewController {

    @IBOutlet weak var clockImage: UIImageView!
    
    @IBOutlet weak var bedroomView: UIView!
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        
        let path: String! = Bundle.main.resourcePath?.appending("/clock.mp3")
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
        
        clockImage.animationImages = [UIImage(named: "clock-rotate1.jpg"), UIImage(named: "clock-rotate2.jpg")] as? [UIImage]
        
        clockImage.animationDuration = 0.4
        
        clockImage.startAnimating()
    }
    
    //Function when user tap the clock.
    @IBAction func clockStop(_ sender: UIButton) {
        clockImage.stopAnimating()
        audioPlayer.stop()
        
        clockImage.image = UIImage(named: "clock.jpg")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "BathroomViewController")
        self.present(VC, animated: false, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.nextView()
        }
    }
    
    //Animation for back.
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.bedroomView.transform = CGAffineTransform(translationX: -self.bedroomView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "goToBathroom", sender: nil)
        })
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

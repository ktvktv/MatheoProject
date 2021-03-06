//
//  PETeacherViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class PETeacherViewController: UIViewController {

    @IBOutlet weak var PEView: UIView!
    @IBOutlet weak var mouthTeacher: UIImageView!
    
    var audioPlayer : AVAudioPlayer!
    
    override func viewWillAppear(_ animated: Bool) {
        mouthTeacher.animationImages = [UIImage(named: "mouth1.jpg"), UIImage(named: "mouth2.jpg"), UIImage(named: "mouth3.jpg"), UIImage(named: "mouth4.jpg")] as? [UIImage]
        
        mouthTeacher.animationDuration = 0.5
        
        mouthTeacher.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + audioPlayer.duration + 0.5) {
            self.mouthTeacher.stopAnimating()
            self.audioPlayer.stop()
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "ChangeClothesViewController")
            self.present(VC, animated: false, completion: nil)
            
            self.nextView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        audioPlayer.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/guruPE.mp3")
        let mp3URL = URL.init(string: path)
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: mp3URL!)
            audioPlayer.numberOfLoops = 0
        }
        catch
        {
            print("An error occurred while trying to extract audio file")
        }
    }

    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.PEView.transform = CGAffineTransform(translationX: -self.PEView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "changeClothes", sender: nil)
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

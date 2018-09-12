//
//  TeacherComingViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class TeacherComingViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var teacherImageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.teacherImageView.startAnimating()
            self.audioPlayer.play()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + audioPlayer.duration + 0.8) {
            self.teacherImageView.stopAnimating()
            self.audioPlayer.stop()
            
            let transition = CATransition()
            transition.duration = 0.5
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
            self.view.window!.layer.add(transition, forKey: kCATransition)
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "TeacherViewController")
            self.present(VC, animated: false, completion: nil)
            
            self.nextView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/morning.mp3")
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
        
        teacherImageView.animationImages = [UIImage(named: "teacher1.jpg"), UIImage(named: "teacher2.jpg"), UIImage(named: "teacher3.jpg"), UIImage(named: "teacher2.jpg"), UIImage(named: "teacher1.jpg")] as? [UIImage]
        
        teacherImageView.animationDuration = 1
    }

    @IBOutlet weak var teacherView: UIView!
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.teacherView.transform = CGAffineTransform(translationX: -self.teacherView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "PEClass", sender: nil)
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

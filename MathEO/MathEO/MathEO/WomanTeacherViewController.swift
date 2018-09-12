//
//  WomanTeacherViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 07/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class WomanTeacherViewController: UIViewController {
    
    enum state {
        case on, off
    }

    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var womanMouth: UIImageView!
    
    @IBOutlet weak var digitalClock: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        womanMouth.animationImages = [UIImage(named: "mouth2.jpg"), UIImage(named: "mouth3.jpg"), UIImage(named: "mouth4.jpg")] as? [UIImage]
        
        womanMouth.animationDuration = 0.5
        
        womanMouth.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.audioPlayer.play()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.audioPlayer.duration - 0.5) {
            self.womanMouth.stopAnimating()
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let path: String! = Bundle.main.resourcePath?.appending("/womanTeacher.mp3")
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
        
        progressBar.progress = 0
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapNow))
        
        teacherView.addGestureRecognizer(tapGesture)
    }
    
    var count = 0
    
    @objc func tapNow() {
        
        progressBar.addProgress(0.34)
        
        if count == 0 {
            digitalClock.image = UIImage(named: "digitalclock2.jpg")
        }
        else if count == 1 {
            digitalClock.image = UIImage(named: "digitalclock3.jpg")
        }
        else if count == 2 {
            digitalClock.image = UIImage(named: "digitalclock4.jpg")
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)
                let VC = self.storyboard!.instantiateViewController(withIdentifier: "ExamViewController")
                
                self.present(VC, animated: false, completion: nil)
                self.nextView()
                
                self.nextView()
            }
        }
        
        count += 1
    }

    @IBOutlet weak var teacherView: UIView!
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.teacherView.transform = CGAffineTransform(translationX: -self.teacherView.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "goToExam", sender: nil)
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

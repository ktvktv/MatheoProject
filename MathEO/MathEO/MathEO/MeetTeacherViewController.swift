//
//  MeetTeacherViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 06/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class MeetTeacherViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!

    @IBOutlet weak var matheoImage: UIImageView!
    
    @IBOutlet weak var teacherView: UIView!
    
    @IBOutlet weak var bodyView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        bodyView.animationImages = [UIImage(named: "matheobody.jpg"), UIImage(named: "matheobody2.jpg"), UIImage(named: "matheobody3.jpg"), UIImage(named: "matheobody2.jpg"), UIImage(named: "matheobody.jpg")] as? [UIImage]
        
        bodyView.animationDuration = 3
        
        bodyView.startAnimating()
        
        UIView.animate(withDuration: 3, animations: {
            let tf = CGAffineTransform(translationX: 150, y: 0)
            
            self.bodyView.transform = tf
            self.matheoImage.transform = tf
            
        }) { (bool) in
            self.audioPlayer.play()
            self.bodyView.stopAnimating()
            
            UIView.animate(withDuration: 5, animations: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                    self.bodyView.isHidden = true
                    self.matheoImage.isHidden = true
                }
                self.bodyView.startAnimating()
                
                let tf = CGAffineTransform(translationX: 500, y: 0)
                
                self.bodyView.transform = tf
                self.matheoImage.transform = tf
            }){(bool) in
                self.bodyView.stopAnimating()
                self.audioPlayer.stop()
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromRight
                transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
                self.view.window!.layer.add(transition, forKey: kCATransition)
                let VC = self.storyboard!.instantiateViewController(withIdentifier: "goToWomanTeacher")
                self.present(VC, animated: false, completion: nil)
                
                self.nextView()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/hello.mp3")
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
                self.teacherView.transform = CGAffineTransform(translationX: -self.teacherView.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "goToWomanTeachers", sender: nil)
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

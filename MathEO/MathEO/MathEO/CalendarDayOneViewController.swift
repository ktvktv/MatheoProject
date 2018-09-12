//
//  CalendarDayOneViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 05/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit
import AVFoundation

class CalendarDayOneViewController: UIViewController {
    
    //Properties.
    @IBOutlet weak var calendarImage: UIImageView!
    
    @IBOutlet weak var calendarOneView: UIView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var audioPlayer : AVAudioPlayer!
    
    //Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let path: String! = Bundle.main.resourcePath?.appending("/paper-ripped.mp3")
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
        
        calendarImage.animationImages = [UIImage(named: "calendar1.jpg"), UIImage(named: "calendar2.jpg"), UIImage(named: "calendar3.jpg"), UIImage(named: "calendar4.jpg")] as? [UIImage]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarImage.animationRepeatCount = 1
        calendarImage.animationDuration = 1.5
        calendarImage.startAnimating()
        audioPlayer.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + calendarImage.animationDuration) {
            self.nextView()
        }
    }
    
    //Animation into next page.
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.calendarOneView.transform = CGAffineTransform(translationX: -self.calendarOneView.bounds.width, y: 0)
            }
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "goToBedroom", sender: nil)
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

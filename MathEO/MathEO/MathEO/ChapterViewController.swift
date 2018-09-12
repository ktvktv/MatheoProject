//
//  ChapterViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 09/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController {

    @IBOutlet weak var chapterView: UIView!
    
    @IBOutlet weak var matheoHead: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        matheoHead.animationImages = [UIImage(named: "matheohead2.jpg"), UIImage(named: "matheohead1.jpg"), UIImage(named: "matheohead2.jpg"), UIImage(named: "matheohead3.jpg")] as? [UIImage]
        
        matheoHead.animationDuration = 0.5
        
        matheoHead.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextView))
        
        matheoHead.addGestureRecognizer(tapGesture)
    }
    
    @objc func nextView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "CalendarDayOneViewController")
        present(VC, animated: false, completion: nil)
        
        UIView.animateKeyframes(withDuration: 2, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.chapterView.transform = CGAffineTransform(translationX: -self.chapterView.bounds.width, y: 0)
            })
        }, completion: {(_ : Bool) in
            self.performSegue(withIdentifier: "goToCalendar", sender: nil)
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

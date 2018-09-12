//
//  EndingViewController.swift
//  MathEO
//
//  Created by Kevin Tigravictor on 07/09/18.
//  Copyright © 2018 Binus University. All rights reserved.
//

import UIKit

class EndingViewController: UIViewController {

    @IBOutlet weak var birdView: UIImageView!
    
    @IBOutlet weak var wheelView: UIImageView!
    
    @IBOutlet weak var carView: UIImageView!
    
    @IBOutlet weak var background1: UIImageView!
    
    @IBOutlet weak var background2: UIImageView!
    enum state {
        case right, left
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var mainMenuImage: UIImageView!
    
    var birdState = state.right
    
    override func viewWillAppear(_ animated: Bool) {
        wheelView.startAnimating()
        
        birdView.animationDuration = 0.5
        birdView.startAnimating()
        
        mainMenuImage.startAnimating()
        
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.birdView.transform = CGAffineTransform(translationX: -200, y: 0)
            self.label.transform = CGAffineTransform(translationX: 0, y: 50)
        }, completion: nil)
        
        UIView.animate(withDuration: 3, delay: 0, options: [.repeat], animations: {
            self.background1.transform = CGAffineTransform(translationX: -self.background1.frame.width, y: 0)
            self.background2.transform = CGAffineTransform(translationX: -self.background1.frame.width, y: 0)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wheelView.animationImages = [UIImage(named: "wheels1.jpg"), UIImage(named: "wheels2.jpg")] as? [UIImage]
        
        birdView.animationImages = [UIImage(named: "bird1.jpg"), UIImage(named: "bird2.jpg"), UIImage(named: "bird3.jpg"), UIImage(named: "bird2.jpg"), UIImage(named: "bird1.jpg")] as? [UIImage]
        
        background2.frame.origin.x = background2.bounds.width
        
        mainMenuImage.animationImages = [UIImage(named: "mainmenu1.jpg"), UIImage(named: "mainmenu2.jpg")] as! [UIImage]
        
        mainMenuImage.animationDuration = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func goToMainMenu(_ sender: Any) {
        mainMenuImage.stopAnimating()
        birdView.stopAnimating()
        wheelView.stopAnimating()
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "mainMenuStory")
        present(VC, animated: false, completion: nil)
        
        nextView()
    }
    
    @IBOutlet weak var endingView: UIView!
    
    func nextView() {
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.endingView.transform = CGAffineTransform(translationX: -self.endingView.bounds.width, y: 0)
            }
        }, completion: {(finished: Bool) in
            self.performSegue(withIdentifier: "mainMenu", sender: nil)
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

//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController {
    
    @IBOutlet weak var fadeInButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up. -- C
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button -- C
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers -- C
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires! -- C
     *
     */
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        
        fadeInButton.titleLabel?.text = "Fade In"
        animationTheme()
    }
    
    //MARK: - animation view appearance
        func animationTheme() {
            blueButtonTheme(button: fadeInButton)
     
            logoImage.image = #imageLiteral(resourceName: "ic_logo")
            logoImage.frame = CGRect(x: (view.center.x / 2), y: (view.center.y / 2) + 100, width: 200, height: 100)
            logoImage.contentMode = .scaleAspectFit
        }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        
        if fadeInButton.titleLabel?.text == "Fade In" {
            fadeInButton.setTitle("Fade Out", for: .normal)
            logoFadeIn()
        } else {
            fadeInButton.setTitle("Fade In", for: .normal)
            logoFadeOut()
        }
    }

    //MARK: - fading animations end effects
    func logoFadeOut() {
        UIImageView.animate(withDuration: 0.9, animations: {
            self.logoImage.alpha = 1.0
            self.view.backgroundColor = .white
        })
    }
    
    func logoFadeIn() {
        UIImageView.animate(withDuration: 0.9, animations: {
            self.logoImage.alpha = 0.0
            self.view.backgroundColor = .black
        })
    }
}

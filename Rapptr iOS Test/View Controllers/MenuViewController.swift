//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */

    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    @IBOutlet var chatView: UIView!
    @IBOutlet weak var buttonStack: UIStackView!
    
    
    // UI background image
    private var backgroundImage: UIImageView =  {
    
        var backgroundImage = UIImageView()
        return backgroundImage
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coding Tasks"
        
        setTheme()
        menuConstraints()

    }
    
    //MARK: - Theme Settings
    func setTheme() {
        
        let chatViewHeight = view.frame.height
        let chatViewWidth = view.frame.width
        backgroundImage.frame = CGRect(x: 0, y: 0, width: chatViewWidth, height: chatViewHeight)
        backgroundImage.image = #imageLiteral(resourceName: "bg_home_menu")
        
        //chatView.insertSubview(backgroundImage, at: 0)
        view.insertSubview(backgroundImage, at: 0)
        
        buttonTheme(buttons: [chatButton, loginButton, animationButton])
        chatButton.titleLabel?.text = "CHAT"
        loginButton.titleLabel?.text = "LOGIN"
        animationButton.titleLabel?.text = "ANIMATION"
                
   
        chatButton.setImage(UIImage(named: "ic_chat"), for: .normal)
        loginButton.setImage(UIImage(named: "ic_login"), for: .normal)
        animationButton.setImage(UIImage(named: "ic_animation"), for: .normal)
        
    }
    
    //MARK: - Constraints Settings
    
    func menuConstraints() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.spacing = 24
    
        NSLayoutConstraint(item: buttonStack!, attribute: .width, relatedBy: .equal, toItem: chatView, attribute: .width, multiplier: 0.5, constant: (chatView.frame.size.width - 60) / 2 ).isActive = true
        
        NSLayoutConstraint(item: buttonStack!, attribute: .centerY, relatedBy: .equal, toItem: chatView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
       
        chatButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: chatButton!, attribute: .centerX, relatedBy: .equal, toItem: chatView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: loginButton!, attribute: .centerX, relatedBy: .equal, toItem: chatView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        animationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: animationButton!, attribute: .centerX, relatedBy: .equal, toItem: chatView, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
    }
    

    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
}

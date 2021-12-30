//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Network

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user ---C
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in ----C
     *
     * 4) Calculate how long the API call took in milliseconds ---C
     *
     * 5) If the response is an error display the error in a UIAlertController ---C
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController ----C
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu. ----C
     **/
    
    // MARK: - Properties
    //private var client: checkLogin?

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet var loginView: UIView!
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    
    let client = checkLogin()
    let connection = checkDeviceWifi()
    
    var startTime: Double = 0
    var time: Double = 0
    weak var timer: Timer?
    
    // UI Background Image
    private var backgroundImage: UIImageView = {
        
        let backgroundImage = UIImageView()
        return backgroundImage
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        userEmail.text = ""
        userPassword.text = ""
        
        themeConfiguration()
        constraintsSettings()
        userEntryFieldSettings(textField: [userPassword,userEmail])
        
    
    }
    
    //MARK: - Constraints
    func constraintsSettings() {
        
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        userEmail.translatesAutoresizingMaskIntoConstraints = false
        userPassword.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: loginStackView!, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        
        NSLayoutConstraint(item: loginStackView!, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.5, constant: (view.frame.size.width - 60) / 2 ).isActive = true
        
        NSLayoutConstraint(item: loginStackView!, attribute: .top, relatedBy: .equal, toItem: backButton, attribute: .bottomMargin, multiplier: 1.0, constant: 64).isActive = true
        

    }
    
    //MARK: - Theme Settings
    func themeConfiguration() {
        
        blueButtonTheme(button: loginButton)
        
        userEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.loginPlacholderColor])
        
        userPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.loginPlacholderColor])
        
        backgroundImage.frame = CGRect(x: 0.0, y: 64.0, width: loginView.frame.size.width , height: loginView.frame.size.height - 64)
        backgroundImage.image = #imageLiteral(resourceName: "img_login")
        loginView.insertSubview(backgroundImage, at: 0)
    }
    
    
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    

    @IBAction func didPressLoginButton(_ sender: Any) {
        print("Button Pressed")
        
        
        if self.userEmail.text?.isEmpty == false || self.userPassword.text?.isEmpty == false {
            //check connection before user log in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                self.checkConnectionAndLogin()
            }
            
        } else {
            
            let alert = UIAlertController(title: "User Input Empty", message: "Please enter your credentials", preferredStyle: .alert)
            
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(dismissAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - API Duration Process
    @objc func returnDuration(timer: Timer) -> String {
        
        time = Date().timeIntervalSinceReferenceDate - startTime
        
        let timedValue = String(format: "%.3f", time)
        return timedValue
    }
    
    
    //MARK: - Check Wifi Connection & User Log In Credentials
    
    // checking device connection before processing API call.
    func checkConnectionAndLogin() {
        connection.testConnection(completion: {
            result in
            
            switch result {
            case .success(let goodConnection):
                print(goodConnection)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    self.processLogInAPI()
                }
                
            case .failure(let error):
                
                let errorWifi = error as! NetworkError
                DispatchQueue.main.async {
                    self.alertFailure(errorMessage: errorWifi.rawValue)
                }
            }
        })
    }
    
    //MARK: - Check User Log In
    func processLogInAPI() {
        startTime = Date().timeIntervalSinceReferenceDate
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(returnDuration(timer:)), userInfo: nil, repeats: true)
        
        client.loginData(email: userEmail.text!, password: userPassword.text!, completion: {result in
            
            switch result {
            case .success(let responseData):
                print("CHANGE VIEW: \(responseData)")
                
                let loadingTime = self.returnDuration(timer: self.timer!)
                //print(self.returnDuration(timer: self.timer!))
                self.timer?.invalidate()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.alertSuccess(APITime: "\(loadingTime) milliseconds")
                }
                
            case .failure(let error):
                
                let errorMSG = error as! NetworkError
                print(error as! NetworkError)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.alertFailure(errorMessage: errorMSG.rawValue)
                }
                
            }
            
        })
    }
    
//MARK: - Alert Displays
    func alertSuccess(APITime: String) {
        
        let alert = UIAlertController(title: "Log Success", message: APITime, preferredStyle: .alert)
        let nextViewAction = UIAlertAction(title: "Ok", style: .default) { _ in
            
            self.backAction(self)
             return
        }

        alert.addAction(nextViewAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func alertFailure(errorMessage: String) {
        //create alert controller
        let alert = UIAlertController(title: "Page Not Found", message: "\(errorMessage)", preferredStyle: .alert)
        
        // dismiss action
        let dismissAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        
        //check settings response action
        let checkSettings = UIAlertAction(title: "Check Connection", style: .default) {_ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
        
        // display error message based off of error type
        if errorMessage == "Check Network Connection" {
            //check settings
            alert.addAction(checkSettings)
        } else {
            alert.addAction(dismissAction)
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

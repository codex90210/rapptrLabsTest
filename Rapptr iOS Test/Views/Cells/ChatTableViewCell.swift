//
//  ChatTableViewCell.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.


// tableView is 16 PX from the top
// cells lare 24 PX
import UIKit

class ChatTableViewCell: UITableViewCell {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Setup cell to match mockup -- C
     *
     * 2) Include user's avatar image -- C
     **/
    
    // MARK: - Outlets
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var contentCell: UIView!
    
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        chatThemeSettings()
        contentCell.backgroundColor = .viewColor
    }
    
    // MARK: - Public
    func setCellData(message: Messages) {
        header.text = message.name
        body.text = message.message
        let urlImage = message.avatar_url
        let data = try? Data(contentsOf: urlImage!)
        avatarImage.image = UIImage(data: data!)

    }
    
    //MARK: - font & chat content settings
    func chatThemeSettings() {
        header.font = .systemFont(ofSize: 13, weight: .semibold)
        
        avatarImage.backgroundColor = .black
        avatarImage.layer.cornerRadius = avatarImage.frame.size.height / 2
        avatarImage.layer.masksToBounds = true
        
        body.layer.cornerRadius = 8
        body.layer.masksToBounds = true
        body.font = .systemFont(ofSize: 15, weight: .regular)
        body.layer.borderWidth = 1
        body.layer.borderColor = UIColor.chatBorderColor.cgColor
       
        
        body.lineBreakMode = . byWordWrapping
        body.numberOfLines = 0
    }
}

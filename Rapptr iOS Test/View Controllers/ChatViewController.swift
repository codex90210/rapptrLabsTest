//
//  ChatViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up. -- C
     *
     * 2) Using the following endpoint, fetch chat data -- C
     *    URL: http://dev.rapptrlabs.com/Tests/scripts/chat_log.php
     *
     * 3) Parse the chat data using 'Message' model -- C
     *
     **/
    
    // MARK: - Properties
    private var client = ChatClient()
    private var messages = [Messages]()

    // MARK: - Outlets
    @IBOutlet weak var chatTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        themeConfiguration()
        
        DispatchQueue.main.async {
            self.chatAPIData()
        }
    }
    
    //MARK: - Theme Configuration
    
    func themeConfiguration() {
        chatTable.separatorColor = .clear
        chatTable.isHidden = true
        chatTable.alpha = 0.0
        chatTable.backgroundColor = UIColor.viewColor
        view.backgroundColor = .viewColor
        configureTable(tableView: chatTable)
        title = "Chat"
        chatTable.estimatedRowHeight = 200
        chatTable.rowHeight = UITableView.automaticDimension
    }
    
    //MARK: - chatAPI Process
    func chatAPIData() {
        
        client.fetchChatData(completion: { result in
            switch result {
            
            case.success(let chatData):
                print(chatData)
                self.messages = chatData
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    
                    self.chatTable.isHidden = false
                    self.chatTableViewAnimation()
                    self.navigationController?.navigationBar.alpha = 1.0
                    self.chatTable.reloadData()
                }
                
            case.failure(let error):
                let errorMSG = error as! NetworkError
                print(errorMSG.rawValue)
            }
        })
    }
    //MARK: - UI Animations
    func chatTableViewAnimation() {
        
        UITableView.animate(withDuration: 0.3, delay: 0.0, options: [.curveEaseIn],animations: ({
            self.chatTable.alpha = 1.0
        }))
    }
    
    // MARK: - Private
    private func configureTable(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatTableViewCell? = nil
        if cell == nil {
            let nibs = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)
            cell = nibs?[0] as? ChatTableViewCell
        }
        cell?.setCellData(message: messages[indexPath.row])
        cell?.translatesAutoresizingMaskIntoConstraints = false
        cell?.backgroundColor = .viewColor
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    // MARK: - IBAction
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
}

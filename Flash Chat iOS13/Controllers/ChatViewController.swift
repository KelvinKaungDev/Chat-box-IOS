//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var message : [Message] = [
        Message(name: "Kelvin", message: "Hi"),
        Message(name: "Kaung", message: "Hey"),
        Message(name: "Willian", message: "How are you?")
    ]
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

    }
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageIdentifer, for: indexPath)
        cell.textLabel!.text = message[indexPath.row].message
        
        return cell
    }
    
    
}

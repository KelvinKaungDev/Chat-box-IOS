import UIKit
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.messageIdentifer)
        
        loadMessage()
    }

    func loadMessage() {

        db.collection(K.FireBase.collectionName).order(by: K.FireBase.date).addSnapshotListener  { querySnapShot, error in
            self.messages = []

            if error != nil {
                print("error")
            } else {
                let data = querySnapShot?.documents
                if let documents = data {
                    for document in documents {
                        let data = document.data()
                        let sender = data[K.FireBase.sender] as! String
                        let body = data[K.FireBase.body] as! String
                        
                        self.messages.append(Message(name: sender, message: body))
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
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

        if let messageSender = Auth.auth().currentUser?.email, let messageBody = messageTextfield.text {
            db.collection(K.FireBase.collectionName).addDocument(data: [
                  K.FireBase.sender : messageSender,
                  K.FireBase.body : messageBody,
                  K.FireBase.date : Date().timeIntervalSince1970
              ]) { err in
                  if let err = err {
                      print("Error adding document: \(err)")
                  } else {
                      print("Successfully")
                      self.messageTextfield.text = ""
                  }
              }
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageIdentifer, for: indexPath) as! MessagesCell
        cell.message.text = messages[indexPath.row].message
        cell.messageButton.layer.cornerRadius = 10
        
        if messages[indexPath.row].name == Auth.auth().currentUser?.email {
            cell.customerImage.isHidden = true
            cell.userImage.isHidden = false
        } else {
            cell.customerImage.isHidden = false
            cell.userImage.isHidden = true
        }
        
        return cell
    }
    
    
}

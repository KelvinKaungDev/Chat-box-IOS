import UIKit
import FirebaseAuth
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var message : [Message] = [
        Message(name: "Kelvin", message: "Hi"),
        Message(name: "Kaung", message: "Hey"),
        Message(name: "Willian", message: "How are you?")
    ]
    
    override func viewDidLoad() {
        
        tableView.dataSource = self
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.messageIdentifer)
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
                  K.FireBase.body : messageBody
              ]) { err in
                  if let err = err {
                      print("Error adding document: \(err)")
                  } else {
                      print("Successfully")
                  }
              }
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageIdentifer, for: indexPath) as! MessagesCell
        cell.message.text = message[indexPath.row].message
        cell.messageButton.layer.cornerRadius = 10
        
        return cell
    }
    
    
}

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
        
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.messageIdentifer, for: indexPath) as! MessagesCell
        cell.message.text = message[indexPath.row].message
        cell.messageButton.layer.cornerRadius = cell.messageButton.frame.size.height / 5
        
        return cell
    }
    
    
}

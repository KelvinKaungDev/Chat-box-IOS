import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet var customerImage: UIImageView!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var message: UILabel!
    @IBOutlet var messageButton: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

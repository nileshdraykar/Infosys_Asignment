

import UIKit

class GalleryTableViewCell: UITableViewCell {
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

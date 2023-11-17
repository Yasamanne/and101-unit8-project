//
//  NewsCell.swift
//  GlobeTrekkerInsight
//
//  Created by Yasaman Emami on 11/15/23.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsDescript: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

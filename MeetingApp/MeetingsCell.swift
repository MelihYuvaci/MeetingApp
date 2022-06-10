//
//  MeetingsCell.swift
//  MeetingApp
//
//  Created by Melih Yuvacı on 2.06.2022.
//

import UIKit

class MeetingsCell: UITableViewCell {

    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var subjectText: UILabel!
    @IBOutlet weak var detailsText: UILabel!
    @IBOutlet weak var roomText: UILabel!
    @IBOutlet weak var meetingDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

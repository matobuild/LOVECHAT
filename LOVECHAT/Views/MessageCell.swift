//
//  MessageCell.swift
//  LOVECHAT
//
//  Created by kittawat phuangsombat on 2020/3/3.
//  Copyright © 2020 kittawat phuangsombat. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height/4
//        leftImageView.layer.cornerRadius = leftImageView.frame.size.height/4
//        rightImageView.layer.cornerRadius = rightImageView.frame.size.height/4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

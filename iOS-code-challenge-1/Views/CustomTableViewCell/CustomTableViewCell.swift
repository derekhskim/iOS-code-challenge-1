//
//  CustomTableViewCell.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-25.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var backgroundHoldingView: UIView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - awakeFromNib()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureBackground()
    }

    // MARK: - Function
    func configureBackground() {
        backgroundHoldingView.layer.cornerRadius = 10
        backgroundHoldingView.clipsToBounds = true
    }
    
    func updateScheduleCell(courseName: String, room: String, startTime: String, endTime: String) {
        courseNameLabel.text = courseName
        roomLabel.text = room
        timeLabel.text = "\(startTime) - \(endTime)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

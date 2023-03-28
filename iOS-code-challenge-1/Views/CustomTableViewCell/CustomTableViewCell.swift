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
    
    func updateScheduleCell(courseName: String, room: String, startTime: Date, endTime: Date) {
        courseNameLabel.text = courseName
        roomLabel.text = room
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.locale = Locale(identifier: "en_CA")
            
        let startTimeString = dateFormatter.string(from: startTime)
        let endTimeString = dateFormatter.string(from: endTime)
        
        timeLabel.text = "\(startTimeString) - \(endTimeString)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

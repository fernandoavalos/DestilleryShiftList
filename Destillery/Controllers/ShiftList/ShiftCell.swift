//
//  ShiftCell.swift
//  Destillery
//
//  Created by Fernando Avalos on 12/02/22.
//

import UIKit

class ShiftCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var colorLbl: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with shift: Shift) {
        nameLbl.text = "\(shift.name) (\(shift.role))"
        timeLbl.text = getDate(startDate: shift.startDate, endDate: shift.endDate)
        colorLbl.tintColor = getColor(color: shift.color)
    }
    
    func getDate(startDate: Date, endDate: Date) -> String {
        let startFormatter = DateFormatter()
        startFormatter.dateFormat = "E, MMM d H-"
        let startDateString = startFormatter.string(from: startDate)
        let endFormatter = DateFormatter()
        endFormatter.dateFormat = "H a"
        let endDateString = endFormatter.string(from: endDate)
        return startDateString + endDateString
    }
    
    func getColor(color: String) -> UIColor {
        switch color {
        case "red":
            return .red
        case "blue":
            return .blue
        case "green":
            return .green
        default:
            return .white
        }
    }
}

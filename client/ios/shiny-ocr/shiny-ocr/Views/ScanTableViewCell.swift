//
//  ScanTableViewCell.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import UIKit

class ScanTableViewCell: UITableViewCell {
  @IBOutlet var dateLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  
  static let id = "ScanTableViewCell"
  static func instanceFromNib() -> UINib {
    UINib(
      nibName: String(describing: self),
      bundle: nil
    )
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func configure(label: String, date: Date) {
    dateLabel.text = String(describing: date)
    titleLabel.text = label
  }
}

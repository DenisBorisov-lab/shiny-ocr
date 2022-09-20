//
//  ViewController.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import UIKit

class ScansViewController: UIViewController {
  @IBOutlet var tableView: UITableView!

  private let mock = ["First", "Second", "eqweqwiqewuiqewiuooqeiwpieoquwioueqwoiupqweiuoeqwioupeqwioueqwiuoeqwiuqewiuoqewiuoqewiouqewiuoqewiuoeiuo"]

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    
    tableView.register(
      ScanTableViewCell.instanceFromNib(),
      forCellReuseIdentifier: ScanTableViewCell.id
    )
  }
}

extension ScansViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    mock.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ScanTableViewCell.id,
      for: indexPath
    ) as? ScanTableViewCell else { return UITableViewCell() }
    
    cell.configure(label: mock[indexPath.row], date: Date())
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension ScansViewController: UITableViewDelegate {}

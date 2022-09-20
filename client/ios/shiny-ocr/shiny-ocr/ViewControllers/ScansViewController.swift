//
//  ViewController.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import UIKit

class ScansViewController: UIViewController {
  @IBOutlet var tableView: UITableView!

  let scans = RecivedScan.mock()

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
    scans.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: ScanTableViewCell.id,
      for: indexPath
    ) as? ScanTableViewCell else { return UITableViewCell() }
    
    cell.configure(scan: scans[indexPath.row])
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

extension ScansViewController: UITableViewDelegate {}

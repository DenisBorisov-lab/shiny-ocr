//
//  ViewController.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import UIKit

class ScansViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var languageMenuButton: UIBarButtonItem!
  
  private let scans = RecivedScan.mock()
  private var currentLanguageOCR: OCRLanguage = .rus

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(
      ScanTableViewCell.instanceFromNib(),
      forCellReuseIdentifier: ScanTableViewCell.id
    )
    
    languageMenuButton.menu = generateChangeLanguageMenu()
  }

  private func generateChangeLanguageMenu() -> UIMenu {
    var actions: [UIAction] = []
    
    // TODO: Сделать конфигурацию
    OCRLanguage.allCases.forEach { element in
      let action = UIAction(
        title: element.introduction,
        handler: { [weak self] _ in
          guard let self else { return }
          self.languageMenuButton.title = element.introduction
          self.currentLanguageOCR = element
        }
      )
      actions.append(action)
    }
    return UIMenu(title: "Язык Сканирования", children: actions)
  }
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    
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

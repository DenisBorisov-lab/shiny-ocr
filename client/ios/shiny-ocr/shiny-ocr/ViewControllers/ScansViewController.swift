//
//  ViewController.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import UIKit
import Photos
import PhotosUI

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
    languageMenuButton.title = currentLanguageOCR.presentationValue
  }

  private func generateChangeLanguageMenu() -> UIMenu {
    var actions: [UIAction] = []
    
    // TODO: Сделать конфигурацию
    OCRLanguage.allCases.forEach { element in
      let action = UIAction(
        title: element.presentationValue,
        handler: { [weak self] _ in
          guard let self else { return }
          self.languageMenuButton.title = element.presentationValue
          self.currentLanguageOCR = element
        }
      )
      actions.append(action)
    }
    return UIMenu(title: "Язык Сканирования", children: actions)
  }
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    showImagePickerController()
  }
  
  private func showImagePickerController() {
    var config = PHPickerConfiguration(photoLibrary: .shared())
    config.filter = PHPickerFilter.images
    let pickerVC = PHPickerViewController(configuration: config)
    pickerVC.delegate = self
    present(pickerVC, animated: true)
  }
  
  private func sendImageForOCR(_ image: UIImage) {
    
  }
}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension ScansViewController: UITableViewDelegate {}

// MARK: - PHPickerViewControllerDelegate

extension ScansViewController: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    results.first?.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
      if let error = error {
        print(error)
        return
      }

      guard let image = reading as? UIImage else {
        print("reading casting failed")
        return
      }

      DispatchQueue.main.async {
        self.sendImageForOCR(image)
      }
    }
  }
}

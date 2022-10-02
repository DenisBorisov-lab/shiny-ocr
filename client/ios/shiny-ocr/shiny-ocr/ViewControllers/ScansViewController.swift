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
  }
  
  @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
    showImageSelectionAlert()
  }
  
  private func generateChangeLanguageMenu() -> UIMenu {
    let acitons = OCRLanguage.allCases.map { element in
      UIAction(
        title: element.presentationValue,
        state: element == currentLanguageOCR ? .on : .off,
        handler: { [weak self] _ in
          guard let self else { return }
          self.currentLanguageOCR = element
        }
      )
    }
    return UIMenu(title: "", children: acitons)
  }
  
  private func showImageSelectionAlert() {
    let alert = UIAlertController(
      title: "",
      message: nil,
      preferredStyle: .actionSheet
    )
    alert.view.heightAnchor.constraint(equalToConstant: 220).isActive = true
    
    let cancel = UIAlertAction(title: "Отмена", style: .cancel)
    alert.addAction(cancel)
    
    let imageFromLibrary = UIAlertAction(
      title: "Из фотопленки",
      style: .default
    ) { _ in
      self.showImagePickerController()
    }
    alert.addAction(imageFromLibrary)
    
    let imageFromCamera = UIAlertAction(
      title: "Из камеры",
      style: .default
    ) { _ in
      // open camera
    }
    alert.addAction(imageFromCamera)
    
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Язык сканирования:"
    
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.systemBlue, for: .normal)
    button.showsMenuAsPrimaryAction = true
    button.changesSelectionAsPrimaryAction = true
    button.menu = generateChangeLanguageMenu()
    
    alert.view.addSubview(label)
    alert.view.addSubview(button)
    
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 10),
      label.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 16),
      button.centerYAnchor.constraint(equalTo: label.centerYAnchor),
      button.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5)
    ])
    
    present(alert, animated: true)
  }
  
  private func showImagePickerController() {
    var config = PHPickerConfiguration(photoLibrary: .shared())
    config.filter = PHPickerFilter.images
    let pickerVC = PHPickerViewController(configuration: config)
    pickerVC.delegate = self
    present(pickerVC, animated: true)
  }
  
  private func sendImageForOCR(_ image: UIImage) {
    // use service for image sending
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

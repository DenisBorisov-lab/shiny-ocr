//
//  ViewController.swift
//  shiny-ocr
//
//  Created by Igor Buzykin on 20.09.2022.
//

import Photos
import PhotosUI
import UIKit

class ScansViewController: UIViewController {
  @IBOutlet var tableView: UITableView!
  @IBOutlet var addScanButton: UIBarButtonItem!
  
  private let scans = RecivedScan.mock()
  private let scannerManager = ScannerManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(
      ScanTableViewCell.instanceFromNib(),
      forCellReuseIdentifier: ScanTableViewCell.id
    )
    addScanButton.isEnabled = false
    scannerManager.delegate = self
    scannerManager.connectToTesseractServer()
  }

  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    showImageSelectionAlert()
  }

  private func showImageSelectionAlert() {
    let alert = UIAlertController(
      title: nil,
      message: nil,
      preferredStyle: .actionSheet
    )
    let cancel = UIAlertAction(title: "Отмена", style: .cancel)
    alert.addAction(cancel)

    let imageFromLibrary = UIAlertAction(
      title: "Из Фотопленки",
      style: .default
    ) { _ in
      self.showImagePickerController()
    }
    alert.addAction(imageFromLibrary)

    let imageFromCamera = UIAlertAction(
      title: "Из Камеры",
      style: .default
    ) { _ in
      // open camera
    }
    alert.addAction(imageFromCamera)

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
    guard let imageData = image.jpegData(compressionQuality: 1) else { return }
    let scanUUID = UUID()
    let recievedScan = RecivedScan(uuid: scanUUID, scanText: nil, scanDate: Date())
    let sendingScan = SendingScan(format: "jpg", image: imageData, uuid: scanUUID)
    scannerManager.scan(sendingScan)
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

// MARK: - ScannerManagerDelegate

extension ScansViewController: ScannerManagerDelegate {
  func scannerManager(_ manager: ScannerManager, didReceiveScan: RecivedScan) {
    
  }

  func lockScanActions() {
    addScanButton.isEnabled = false
  }

  func unlockScanActions() {
    addScanButton.isEnabled = true
  }
}

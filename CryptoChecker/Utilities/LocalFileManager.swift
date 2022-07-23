//
//  LocalFileManager.swift
//  CryptoChecker
//
//  Created by Feng Yuan Yap on 2022/07/23.
//

import Foundation
import SwiftUI

class LocalFileManager {
  static let instance = LocalFileManager()
  private init() {}
  
  func saveImage(image: UIImage, folderName: String, imageName: String) {
    
    createDirIfNeeded(folderName: folderName)
    
    guard
      let data = image.pngData(),
      let url = getImageUrl(imageName: imageName, folderName: folderName)
    else {return}
    
    do {
      try data.write(to: url)
    } catch let error {
      print("Error saving image: ImageName: \(imageName), \(error)")
    }
  }
  
  func getImage(imageName: String, FolderName: String) -> UIImage? {
    guard
      let url = getImageUrl(imageName: imageName, folderName: FolderName),
            FileManager.default.fileExists(atPath: url.path)
    else {
      return nil
    }
    return UIImage(contentsOfFile: url.path)
  }
  
  private func createDirIfNeeded(folderName: String) {
    guard let url = getFolderUrl(folderName: folderName) else { return }
    
    if !FileManager.default.fileExists(atPath: url.path) {
      do {
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
      } catch let error {
        print("Error creating directory: folderName: \(folderName), \(error)")
      }
    }
  }
  
  private func getFolderUrl(folderName: String) -> URL? {
    guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
      return nil
    }
    return url.appendingPathComponent(folderName)
  }
  
  private func getImageUrl(imageName: String, folderName: String) -> URL? {
    guard let url = getFolderUrl(folderName: folderName) else {
      return nil
    }
    return url.appendingPathComponent(imageName + ".png")
  }
}

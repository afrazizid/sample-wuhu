//
//  Array + Extension.swift
//  WATERCO
//
//  Created by Abdulqadar on 02/12/2019.
//  Copyright © 2019 Abdul Qadar. All rights reserved.
//

import Foundation

extension FileManager {
    func saveFileToDocumentsDirectory(fileUrl: URL, name: String, extention: String) -> URL? {
        let videoData = NSData(contentsOf: fileUrl as URL)
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        
        let filePath = path.appendingPathComponent(name + extention)
        do {
            try videoData?.write(to: filePath)
            
            return filePath
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func saveFileToDocumentsDirectory(image: UIImage, name: String, extention: String) -> URL? {
        let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let imagePath = path.appendingPathComponent(name + extention)
        let jpgImageData = image.jpegData(compressionQuality: 1.0)

//        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
        do {
            try jpgImageData!.write(to: imagePath)
            
            return imagePath
        } catch {
            print(error)
            
            return nil
        }
    }
    
    func removeFileFromDocumentsDirectory(fileUrl: URL) -> Bool {
        do {
            try self.removeItem(at: fileUrl)
            
            return true
        } catch {
            return false
        }
    }
}

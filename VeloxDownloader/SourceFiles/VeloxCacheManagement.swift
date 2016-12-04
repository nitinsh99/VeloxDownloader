//
//  VeloxCacheManagement.swift
//  VeloxDownloader
//
//  Created by Nitin Sharma on 11/30/16.
//  Copyright © 2016 Nitin Sharma. All rights reserved.
//

import Foundation
import CoreGraphics

public class VeloxCacheManagement
{
    
    
    
    //MARK : File Existense
    
    
   static func fileExistForURL(url: URL) -> Bool {
        return self.fileExistForURL(url: url, directory : nil)
    }
    
   static func fileExistForURL(url : URL, directory : String?) -> Bool {
        
        return self.fileExistWithName(name : url.lastPathComponent, directory : directory )
    }
    
   static func fileExistWithName(name : String) -> Bool {
        return self.fileExistWithName(name: name,directory : nil)
    }
    
   static func fileExistWithName(name : String, directory : String?) -> Bool {
        
        var fileExist = false
        var destinationLocation : URL  = self.cachesDirectoryURlPath()
        
        destinationLocation = destinationLocation.appendingPathComponent(name)
        
        
        let exist = FileManager.default.fileExists(atPath: destinationLocation.path)
        if(exist)
        {
            fileExist = true
        }
        return fileExist
    }
    
    
    //Mark : File Management
    
    
    
   static func createDirectoryNamed(name : URL) -> Bool {
        
        let directory = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])
        
        
        do {
            try FileManager.default.createDirectory(at: directory as URL, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch _ as NSError {
            return false
        }
        
    }
    
   static func cachesDirectoryURlPath() -> URL {
        
        let cachesDirectoryURLPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])
        
        return cachesDirectoryURLPath
    }
    
    
    
   static func fileDownloadCompletedForURL(url: URL) -> Bool {
        var flag = true
        
        if(VeloxDownloadManager.downloadInstanceDictionary != nil)
        {
            
            let downloadInstance = VeloxDownloadManager.downloadInstanceDictionary![url.lastPathComponent]
            if(downloadInstance == nil)
            {
                flag = false
            }
        }
        return flag
    }
    
    
   static func isFileDownloadingWithURL(url : URL) -> Bool {
        return VeloxCacheManagement.isFileDownloadingWithURL(url: url,progress : nil)
    }
    
   static func isFileDownloadingWithURL(url : URL,progress : ((CGFloat,VeloxDownloadInstance)-> ())? ) -> Bool {
        return self.isFileDownloadingWithURL(url: url, progress: progress,completion: nil)
    }
    
    static func isFileDownloadingWithURL(url : URL,progress : ((CGFloat,VeloxDownloadInstance)->())?,completion: ((Bool)-> ())?) -> Bool {
        var flag = false
        
        if(VeloxDownloadManager.downloadInstanceDictionary != nil)
        {
            let dowloadInstance = VeloxDownloadManager.downloadInstanceDictionary![url.lastPathComponent]
            if(dowloadInstance != nil)
            {
                if(progress != nil)
                {
                    dowloadInstance!.currentProgressClosure = progress!
                }
                if(completion != nil)
                {
                    dowloadInstance!.downloadStatusClosure = completion!
                }
                flag = true
            }
        }
        return flag
    }
    
    
    // MARK : File Deletion
    
    
    
   static func deleteFileForURL(url: URL) -> Bool {
        return self.deleteFileForURL(url: url,directory : nil)
    }
    
   static func deleteFileForURL(url : URL,directory : String?) -> Bool {
        return self.deleteFileWithName(name: url.lastPathComponent)
    }
    
   static func deleteFileWithName(name : String) -> Bool {
        return self.deleteFileWithName(name: name,directory : nil)
    }
    
   static func deleteFileWithName(name : String, directory : String?) -> Bool {
        var fileLocation : URL
        if(directory == nil){
            fileLocation =  URL(string: self.cachesDirectoryURlPath().appendingPathComponent(name).absoluteString)!
        }
        else
        {
            fileLocation = URL(fileURLWithPath: directory!)
        }
        
        do {
            try
                FileManager.default.removeItem(atPath: fileLocation.path)
            return true
        } catch  _ as NSError {
            return false
        }
    }
    
    //MARK : Clean directory
    
    
    static func cleanTempDirectory() -> Void {
        do
        {
            let tempDir = try FileManager.default.contentsOfDirectory(atPath: NSTemporaryDirectory())
            
            for file in tempDir
            {
                print("Deleted file named : \(file) from the temp folder")
                try FileManager.default.removeItem(atPath: NSTemporaryDirectory().appending(file))
            }
            
            
        }
        catch let error as NSError
        {
            print("error occured with code \(error.code) and des : \(error.localizedDescription)")
        }
        
        
    }
    
}

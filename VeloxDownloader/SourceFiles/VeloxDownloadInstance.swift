//
//  VeloxDownloadInstance.swift
//  VeloxDownloader
//
//  Created by Nitin Sharma on 11/28/16.
//  Copyright © 2016 Nitin Sharma. All rights reserved.
//

import Foundation
import CoreGraphics


public class VeloxDownloadInstance : NSObject
{
    
    typealias remainingDownloadTime = ((CGFloat) -> (Void))?
    typealias currentProgressStat = ((CGFloat,VeloxDownloadInstance) -> (Void))?
    typealias isDownloadCompleted = ((Bool) -> (Void))?
    
    
    var remainingTimeClosure : remainingDownloadTime
    var currentProgressClosure : currentProgressStat
    var downloadStatusClosure : isDownloadCompleted
    
    var downloadTask : URLSessionDownloadTask
    var filename : String
    var friendlyName : String
    var filePath : String
    var downloadDate : Date
    
    
    init(withDownloadTask : URLSessionDownloadTask, remainingTime :  remainingDownloadTime , progess :  currentProgressStat, status :  isDownloadCompleted,  name :  String, friendlyName :  String, path :  String, date :  Date ) {
        
        
            self.downloadTask = withDownloadTask
            self.remainingTimeClosure = remainingTime
            self.currentProgressClosure = progess
            self.downloadStatusClosure = status
            self.filename = name
            self.friendlyName = friendlyName
            self.filePath = path
            self.downloadDate = date
        
    }
    
    
    
    
}

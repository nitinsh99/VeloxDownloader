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
    
   public typealias remainingDownloadTime = ((CGFloat) -> (Void))?
   public typealias currentProgressStat = ((CGFloat,VeloxDownloadInstance) -> (Void))?
   public typealias isDownloadCompleted = ((Bool) -> (Void))?
    
    
    public var remainingTimeClosure : remainingDownloadTime
    public var currentProgressClosure : currentProgressStat
    public var downloadStatusClosure : isDownloadCompleted
    
    public var downloadTask : URLSessionDownloadTask
    public var filename : String
    public var friendlyName : String
    public var filePath : String
    public var downloadDate : Date
    
    
    public init(withDownloadTask : URLSessionDownloadTask, remainingTime :  remainingDownloadTime , progess :  currentProgressStat, status :  isDownloadCompleted,  name :  String, friendlyName :  String, path :  String, date :  Date ) {
        
        
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

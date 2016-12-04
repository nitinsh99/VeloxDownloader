//
//  ViewController.swift
//  VeloxDownloader
//
//  Created by Nitin Sharma on 11/28/16.
//  Copyright © 2016 Nitin Sharma. All rights reserved.
//

import UIKit



public class ViewController: UIViewController {
    
    weak var progressBar2: UIProgressView!
    weak var progressBar1: UIProgressView!
    
    
    weak var scrollView: UIScrollView!

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.progressBar1.progress = 0.0
        self.progressBar2.progress = 0.0
        
        let controller = VeloxDownloaderList(nibName: "VeloxDownloaderList", bundle: nil)
        self.addChildViewController(controller)
        controller.view.frame = scrollView.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    
   
    func nativeDownloadingRequested(_ sender: Any) {
        
        let downloader1 = VeloxDownloadManager.sharedInstance
        let url = "http://download.thinkbroadband.com/1MB.zip"
        let url12 = "http://download.thinkbroadband.com/20MB.zip"
        
        let url1 = URL(string: url)
        let url2 = URL(string: url12)
        

        let progressClosure : (CGFloat,VeloxDownloadInstance) -> (Void)
        progressClosure = {(progress,downloadInstace) in
        
            if(downloadInstace.filename == "20MB.zip")
            {
                self.progressBar1.progress = Float(progress)
            }
            if(downloadInstace.filename == "1MB.zip")
            {
                self.progressBar2.progress = Float(progress)
            }
            
        
        }
        
        let remainingTimeClosure : (CGFloat) -> Void
        
        remainingTimeClosure = {(timeRemaning) in
        
            print("Remaining Time is : \(timeRemaning)")
        }
        
        let completionClosure : (Bool) -> Void
        completionClosure = {(status) in
        print("is Download completed : \(status)")
        }
        
        
        downloader1.downloadFile(withURL: url1!, name: url1!.lastPathComponent, directoryName: nil, friendlyName: nil, progressClosure: progressClosure, remainigtTimeClosure: remainingTimeClosure, completionClosure: completionClosure, backgroundingMode: false)
        
          downloader1.downloadFile(withURL: url2!, name: url2!.lastPathComponent, directoryName: nil, friendlyName: nil, progressClosure: progressClosure, remainigtTimeClosure: remainingTimeClosure, completionClosure: completionClosure, backgroundingMode: false)
    }
    
    
       
    func veloxDownloadingRequested(_ sender: Any) {
    
    
        let downloader2 = VeloxDownloadManager.sharedInstance

       
            let url = "http://download.thinkbroadband.com/10MB.zip"
            let url12 = "http://download.thinkbroadband.com/30MB.zip"

            let url1 = URL(string: url)
            let url2 = URL(string: url12)
            
           
    
            
                downloader2.downloadFileWithVeloxDownloader(withURL: url2!, name: url2!.lastPathComponent, directoryName: nil, friendlyName: nil, backgroundingMode: false)

                downloader2.downloadFileWithVeloxDownloader(withURL: url1!, name: url1!.lastPathComponent, directoryName: nil, friendlyName: nil, backgroundingMode: false)
                
        
        
    }
   

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


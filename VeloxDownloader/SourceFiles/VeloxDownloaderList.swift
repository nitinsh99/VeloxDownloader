//
//  VeloxDownloadList.swift
//  VeloxDownloader
//
//  Created by Nitin Sharma on 11/30/16.
//  Copyright © 2016 Nitin Sharma. All rights reserved.
//

import UIKit

public class VeloxDownloaderList: UIViewController,UITableViewDelegate,UITableViewDataSource,DownloadManagerDelegate {
    
    @IBOutlet weak var downloadListTableView: UITableView!
    
    public var downloadListArray = [VeloxDownloadInstance]()
    override public func viewDidLoad() {
        super.viewDidLoad()
        downloadListTableView.tableFooterView = UIView()
        
        downloadListTableView.delegate = self
        downloadListTableView.dataSource = self
        let downloadManager = VeloxDownloadManager.sharedInstance
        downloadManager.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(VeloxDownloaderList.downloadStopped(notification:)), name: NSNotification.Name(rawValue: "downloadStopped"), object: nil)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    public func downloadItemAdded(downloadInstance: VeloxDownloadInstance) {
        print("received a callback saying that download item has been added \(downloadInstance.downloadTask.taskIdentifier)")
        downloadListArray.append(downloadInstance)
        DispatchQueue.main.async {
            self.downloadListTableView.reloadData()
            
        }    }
    
    public func downloadItemRemoved(downloadInstance: VeloxDownloadInstance) {
        
        
        
        print("received a callback saying that download has to be removed\(downloadInstance.filename)")
        if let indexToBeRemoved  = downloadListArray.index(of: downloadInstance)
        {
            downloadListArray.remove(at: indexToBeRemoved)
            VeloxDownloadManager.downloadInstanceDictionary!.removeValue(forKey: downloadInstance.filename)
        }
        DispatchQueue.main.async {
            self.downloadListTableView.reloadData()
            
        }
    }
    
    func downloadStopped(notification : Notification) {
        print("received a callback saying that download has to be stopped for \(notification.userInfo!)")
        
        if let userInfoFromNotification  = notification.userInfo
        {
            
            if let downloadInstanceToBeRemoved =  userInfoFromNotification["velox"] as? VeloxDownloadInstance
            {
                if let indexToBeRemoved  = downloadListArray.index(of: downloadInstanceToBeRemoved)
                {
                    downloadListArray.remove(at: indexToBeRemoved)
                     VeloxDownloadManager.downloadInstanceDictionary!.removeValue(forKey: downloadInstanceToBeRemoved.filename)
                }
                DispatchQueue.main.async {
                    downloadInstanceToBeRemoved.downloadTask.cancel()
                    self.downloadListTableView.reloadData()
                    
                }
            }
            
        }
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        //cell = downloadListTableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let bundle  = Bundle(for: VeloxProgressiveCell.self)
        
        
//        cell = Bundle.main.loadNibNamed("VeloxProgressiveCell", owner: self, options: nil)?.first as! VeloxProgressiveCell
//        
          cell = bundle.loadNibNamed("VeloxProgressiveCell", owner: self, options: nil)?.first as! VeloxProgressiveCell
        
        let cellLabel : UILabel
        let cellProgressBar : UIProgressView
        cellLabel = cell.contentView.viewWithTag(100) as! UILabel
        cellProgressBar = cell.contentView.viewWithTag(200) as! UIProgressView
        cellProgressBar.transform = CGAffineTransform(scaleX: 1, y: 8)
        cellProgressBar.layer.cornerRadius = 8
        
        let downloadItem  = self.downloadListArray[indexPath.row]
        
        if(downloadListArray.count>0)
        {
            //cellLabel.text = downloadItem.filename
            cellLabel.text = downloadListArray[indexPath.row].filename
            let progressClosure: (CGFloat,VeloxDownloadInstance) -> () = { (progress,downloadInstance) in
                
                cellProgressBar.progress = Float(progress)
            }
            let remainingTimeClosure: (CGFloat) -> () = { (remainingTime) in
                
                
            }
            let completionClosure: (Bool) -> () = { (completion) in
                
            }
            downloadItem.currentProgressClosure = progressClosure
            downloadItem.remainingTimeClosure = remainingTimeClosure
            downloadItem.downloadStatusClosure = completionClosure
        }
        else
            
        {
            cellLabel.text = ""
        }
        
        
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (downloadListArray.count)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

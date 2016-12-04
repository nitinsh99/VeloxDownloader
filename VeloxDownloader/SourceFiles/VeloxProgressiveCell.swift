//
//  VeloxProgressiveCell.swift
//  VeloxDownloader
//
//  Created by Nitin Sharma on 12/1/16.
//  Copyright © 2016 Nitin Sharma. All rights reserved.
//

import UIKit




public class VeloxProgressiveCell: UITableViewCell {

    
    @IBOutlet weak var progressBar: UIProgressView!
    //-1 for stopped
    //0 for paused
    //1 for downloading
    
    
    @IBOutlet weak var fileName: UILabel!
    
    
    @IBOutlet weak var cancelButton: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 

 
    @IBAction func stopButtonClicked(_ sender: Any) {
        
        
        
        
        cancelButton.isHidden = true
        // update the table view here
        let button  = sender as! UIButton
        if let cell = button.superview?.superview
        {
            let cellView = cell as! VeloxProgressiveCell
            print("index number is \(cellView.fileName.text!) and cell instance is \(cellView)")
            let removedDownloadInstance  = VeloxDownloadManager.downloadInstanceDictionary![cellView.fileName.text!]!
            print("instance is \(removedDownloadInstance.filename) ")
            
            var userInfo = Dictionary<String,VeloxDownloadInstance>()
            userInfo["velox"] = removedDownloadInstance
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downloadStopped"), object: nil, userInfo: userInfo)
        }
        
    }
    
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

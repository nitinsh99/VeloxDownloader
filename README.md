#VeloxDownloader

##About:
VeloxDownloader is an easy to use,elegant, native yet powerfull download library made with Swift 3. It abstracts all the complex implementations of urlsession and download tasks and provide a "one-click" API which enables you to download the files from the internet.

It's asyncronous, fast, maintainable, highly customizable, has backgrounding capabilities and  provides In-built GUI to show and control the download progress of your files.


##See it in Action:

![VeloxDownloader Demo](https://cloud.githubusercontent.com/assets/1389212/20846414/7fc1b224-b897-11e6-99c7-2a5a4e9cca40.gif)

##What can it do?
* It has following modes:
	* With UI:
		* As seen from above demo VeloxDownloader comes with an in built downloaing View that shows the download progress and currently has the ability to stop any download.
		* This API let you control if you want to enable background downloading for any specific file download.
	   
	   
	* WIthout UI:
	   * This API uses Swift closures to return the download progress, time remaining and the completion status of your download. You can use this information to cater your needs or even build your own downloaing progress GUI.
	   * This API also let you enable or disable the background downloading for any specific file download.

	   
##Usage:

* __Installation__ : 

  VeloxDownloader can be installed using [CocoaPods](http://cocoadocs.org/docsets/VeloxDownloader/1.3/). Simply put the following line in your PodFile and run ```pod update``` from your terminal.
  
  ``` pod 'VeloxDownloader', :git => 'https://github.com/nitinsh99/VeloxDownloader.git' ```
  
  
* __Importing__:
  
  Once the pod successfully installs, open the xcode workspace project. In your viewcontroller simply import the VeloxDownloader by using following file.
  
  
  ```import VeloxDownloader```
  
* __Using VeloxDownloader with Velox downloading UI__:
  * I recommened using a scroll view to show the downloading files using the VeloxDownloading table view. Just set the VeloxDownloader view to your scroll view like following:

   ```
   override func viewDidLoad() {
        
        super.viewDidLoad()
        let bundle  = Bundle(for: VeloxDownloaderList.self)
        let controller = VeloxDownloaderList(nibName: "VeloxDownloaderList", bundle: bundle)
        self.addChildViewController(controller)
        
        // scrollView is the outlet variable for your scroll view.
        // it will be used to display velox downloading UI.
        controller.view.frame = scrollView.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        
    }
```

 * Next : Simply use the ```downloadFileWithVeloxDownloader``` like following. All you have to pass is the URL of the file you want to download and rest will be taken care of by the VeloxDownloader.

 ``` 
  IBAction func downloadClicked(_ sender: Any) {
        let veloxDownloader = VeloxDownloadManager.sharedInstance

        let urlString = "http://download.thinkbroadband.com/10MB.zip"
        let url = URL(string: urlString)
 
        veloxDownloader.downloadFileWithVeloxDownloader(withURL: url!, name: url!.lastPathComponent, directoryName: nil, friendlyName: nil, backgroundingMode: false)
        
    }
 ```
  
 * With BackGrounding: Simple pass true in the  ```backgroundingMode``` parameter of the above method.

 ```
veloxDownloader.downloadFileWithVeloxDownloader(withURL: url!, name: url!.lastPathComponent, directoryName: nil, friendlyName: nil, backgroundingMode: true)
 ```
    

#VeloxDownloader

##About: 
VeloxDownloader is an easy to use,elegant, native yet powerfull download library made with Swift 3. It abstracts all the complex implementations of urlsession and download tasks and provide a "one-click" API which enables you to download the files from the internet.

It's asyncronous, fast, maintainable, highly customizable, has backgrounding capabilities and  provides In-built GUI to show and control the download progress of your files.


##See it in Action: 📹

<kbd>![VeloxDownloader Demo](https://cloud.githubusercontent.com/assets/1389212/20846414/7fc1b224-b897-11e6-99c7-2a5a4e9cca40.gif)
</kbd>

##What can it do? 💪🏼
* It has following modes:
	* With UI:
		* As seen from above demo VeloxDownloader comes with an in built downloaing View that shows the download progress and currently has the ability to stop any download.
		* This API let you control if you want to enable background downloading for any specific file download.
	   
	   
	* WIthout UI:
	   * This API uses Swift closures to return the download progress, time remaining and the completion status of your download. You can use this information to cater your needs or even build your own downloaing progress GUI.
	   * This API also let you enable or disable the background downloading for any specific file download.

	   
##Usage: 💻

* __Installation__ : 

  VeloxDownloader can be installed using [CocoaPods](http://cocoadocs.org/docsets/VeloxDownloader/1.4/index.html). Simply put the following line in your PodFile and run ```pod update``` from your terminal.
  

  
 ``` pod 'VeloxDownloader', '~> 1.6' ```

  
  
* __Importing__:
  
  Once the pod successfully installs, open the xcode workspace project. In your viewcontroller simply import the VeloxDownloader by using following file.
  
  
  ```import VeloxDownloader```
  
* __Apple's App Transport Security Settings__:

  Make sure you have **allowed** Allowed Arbitary load in your info.plist for the App Transport Security Settings.
  
  <kbd><img width="560" alt="screen shot 2016-12-04 at 5 36 39 pm" src="https://cloud.githubusercontent.com/assets/1389212/20869797/5126b5f6-ba48-11e6-9b9a-c9b5ec51ea3c.png"></kbd>

  
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

        let urlString = "URL OF YOUR FILE"
        let url = URL(string: urlString)
 
        veloxDownloader.downloadFileWithVeloxDownloader(
        withURL: url!, 
        name: url!.lastPathComponent,
        directoryName: nil, 
        friendlyName: nil, 
        backgroundingMode: false)        
    }
 ```
  
 * With BackGrounding: Simply pass true in the  ```backgroundingMode``` parameter of the above method.

 ```
veloxDownloader.downloadFileWithVeloxDownloader(
withURL: url!, 
name: url!.lastPathComponent, 
directoryName: nil, 
friendlyName: nil, 
backgroundingMode: true)
 ```
    
* __Using VeloxDownloader without Velox downloading UI__:
  * If you are interested in building your own UI to show and track the progress of your downloads, than you can use the following closure syntax to do just that. Obvisiouly, with this mode you don't have to worry about setting the VeloxDownloader UI as we did above in viewDidLoad() method.

 ```
 @IBAction func downloadClicked(_ sender: Any) {
        let veloxDownloader = VeloxDownloadManager.sharedInstance
       
        let urlString = "URL OF YOUR FILE"
        let url = URL(string: urlString)
 
        let progressClosure : (CGFloat,VeloxDownloadInstance) -> (Void)
        let remainingTimeClosure : (CGFloat) -> Void
        let completionClosure : (Bool) -> Void

        
        progressClosure = {(progress,downloadInstace) in           
        print("Progress of File : \(downloadInstace.filename) is \(Float(progress))")        
        }
           
        remainingTimeClosure = {(timeRemaning) in          
            print("Remaining Time is : \(timeRemaning)")
        }
        
        completionClosure = {(status) in
            print("is Download completed : \(status)")
        }
        
        
        veloxDownloader.downloadFile(
        withURL: url!, 
        name: url!.lastPathComponent, 
        directoryName: nil, 
        friendlyName: nil, 
        progressClosure: progressClosure, 
        remainigtTimeClosure: remainingTimeClosure, 
        completionClosure: completionClosure, 
        backgroundingMode: false)       
    }
  ```
 * With BackGrounding: Simply pass true in the  ```backgroundingMode``` parameter of the above method.

##How can I retrieve the downloaded files: 🗂
* All the downloaded files are first downloaded in the temporary directory and post completion they are moved to the default cache directory of your application. 
* You have to manually retrieve the files from your cache diretory before the application is closed. You can use following code to scan you application cache directory:
  
  ```
      do{
         let cachesDirectoryURLPath = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0])
                        
         let dir = try FileManager.default.contentsOfDirectory(atPath: cachesDirectoryURLPath.path)
         for file in dir{
         print("file is : \(file)")
          }
         }
         catch let error as NSError{
         print("error occured while trying to read cache dir \(error.localizedDescription)")
         }
  ```

* VeloxDownloader clears out the temporary directory on every launch to avoid any file naming conflict and preseve system space.
* Also, if there is already a file present in the cache directory, VeloxDownloader removes the files and replaces the file.
* If download is stopped in the middle for a file than VeloxDownloader removes the file traces from the temp and cache directory.

##Demo: 👏🏼
Simply clone (or download) this git project and run it using Xcode 8 preferebally on an iOS 10 simulator or device:

```git clone https://github.com/nitinsh99/VeloxDownloader.git```


##Contribution: ❤️
* Please STAR the project or mention your project name in this [issue](https://github.com/nitinsh99/VeloxDownloader/issues/15) if you are feeling lucky.
* Create a seperate issue if you found a bug for if you have a feature request.
* You are welcome to submit a pull reqeust if you fixed a bug.

##What's cooking: 🍲
* I will be working on VeloxDowloading UI to add more features like play, pause, resume.
* I will be working on improving the VeloxDownloading UI to make it more asthetic.
* I will be working on improving the file management classes to give more flexibility on saving the downloaded files preferably by tying it up wiht SQLLite and/or CoreDate
* I will be working on creating a UI extenstion for file management that will make it easier to navigate and control through the list of downloaded files.
* More work on general notifications while the backgrounding is enabled.

##Credits: 🙏🏼
* Thanks to awesome people behind [Cocoapods](https://cocoapods.org/about)
* I took insipration from [this](https://github.com/chasseurmic/TWRDownloadManager) downloading library written for Obj-C to make VeloxDownloader.


##[License](https://github.com/nitinsh99/VeloxDownloader/blob/master/LICENSE)


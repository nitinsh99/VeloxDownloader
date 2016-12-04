#VeloxDownloader

##About:
VeloxDownloader is an easy to use,elegant, native yet powerfull download library made with Swift 3. It abstracts all the complex implementations of urlsession and download tasks and provide a "one-click" API which enables you to download the files from the internet.

It's asyncronous, fast, maintainable, highly customizable, has backgrounding capabilities and  provides In-built GUI to show and control the download progress of your files.


##See it in Action:

![VeloxDownloader Demo](https://cloud.githubusercontent.com/assets/1389212/20846414/7fc1b224-b897-11e6-99c7-2a5a4e9cca40.gif)

##What can it do?:
* It has following modes:
	* With UI:
		* As seen from above demo VeloxDownloader comes with an in built downloaing View that shows the download progress and currently has the ability to stop any download.
		* This API let you control if you want to enable background downloading for any specific file download.
	   
	   
	* WIthout UI:
	   * This API uses Swift closures to return the download progress, time remaining and the completion status of your download. You can use this information to cater your needs or even build your own downloaing progress GUI.
	   * This API also let you enable or disable the background downloading for any specific file download.

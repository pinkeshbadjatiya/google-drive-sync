# google-drive-sync
A wrapper function for grive, a terminal based google drive sync utility.  
  


![google-grive-sync Screenshot][logo]

[logo]: http://i.imgur.com/3J9KuQX.png "google-grive-sync Screenshot"


### Note  
The code is essentially naive but very useful if you want to sync data on drive.google.com using terminal.  
Another factor, why i use this code is, i do not need to change my directory location for syncing(like in dropbox) where we sync a single folder. We can just soft link the folder and make sure they are not dangling links before syncing.  



### INSTRUCTIONS  
- <b>Setup grive</b>  
Initial instructions to setup grive can be found at  
https://github.com/Grive/grive  
Grive is now abandoned. Grive2 is out. It is better and more reliable than grive.    
https://github.com/vitalif/grive2  


- <b>Some things to be kept in mind while changing code</b>  
Add custom function. I have used a lot of functions like `HTTP_PROXY` which are declared in .bashrc and do a simple job.  
`HTTP_PROXY`    ->    It just sets up all kinds of terminal proxy and no-proxy variables(Useful if you are working from behind a network).  
`UNSET_PROXY`   ->    Unsets all kinds of proxy and no-proy variables.(Useful if you are working from behind a network)  
`keybindings.pl`  ->  It backs up all the custom keyboard shortcuts assegined in ubuntu. (I use tons of them :))  
`check_internet`  ->  Checks for internet Connectivity both with and without proxy and returns the status code(using curl)  

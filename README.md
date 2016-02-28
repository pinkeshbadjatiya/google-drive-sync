# google-drive-sync
A wrapper function for grive, a terminal based google drive sync utility.  
  


![google-grive-sync Screenshot][logo]

[logo]: http://i.imgur.com/3J9KuQX.png "google-grive-sync Screenshot"


### Note  
If you want to sync data on drive.google.com using terminal and have a very absurd but useful directory sstructure then you are at the right place.  

google-grive-sync is a simple wrapper function written in bash according to custom specifications. It essentially brings various directories, settings, runs some backup-scripts and sructures the code for upload on drive.google.com. Best thing is, it does not move a file. Everything is done by soft/hard linking. This gives a very good directory structure for drive.google.com while keeping the original data intact.  

<b>Why i use this code?</b>  
Because, I do not need to change my directory location for syncing(like in dropbox) where we sync a single folder. We can just soft link the folders and make sure they are not dangling links before syncing.  
The code is essentially naive but very useful after custom tweaks :P. 



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

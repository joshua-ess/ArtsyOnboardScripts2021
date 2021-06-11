# 2021onboarding  

Onboarding Scripts for Artsy Staff
---------------  
    
### Setup Scripts
**account_creator.sh**  ✓  
  creates the admin and loaner accounts, requires input. do not pipe to bash.  
  curl -LO https://git.io/JG2FK && chmod +x JG2FK && sudo ./JG2FK
    
**brew_installer.sh** ✓   
  set up brew and get the base apps in  
  curl -L https://git.io/JG2F7 | bash
    
**change_compname.sh** ✓   
  set name to user-serial number  
  curl -L https://git.io/JG2Fx | sudo bash
    
**dock_cleaner.sh** ✓   
  clean up the dock   
  curl -L https://git.io/JGP8E | bash     
    
**dock_reset.sh** ✓  
  reset the dock to factory defaults   
  curl -L https://git.io/JGPre | bash     
    
**meraki.sh**
  opens chrome to the meraki page / opens profile  
  curl -L https://git.io/JZGof |bash    
     
**set_user_icons.sh** ✓  
  will change users icons to a default logo  
  curl -LO https://git.io/JG2bZ && chmod +x JG2bZ && sudo ./JG2bZ 
     
**set_wallpaper.sh** ✓  
  will set the wallpaper to artsy default 
  curl -L https://git.io/JGPNv | bash
   
**setup.sh**  
  curl -LO https://git.io/JZGgb && chmod +x JZGgb && ./JZGgb 
  do not run as root/admin
    
### Misc. Scripts
**promote_admin.sh**   
  moves user to admin rights  
  curl https://raw.githubusercontent.com/jasonarias/2021onboarding/main/promote_admin.sh | sudo bash  
  curl -L https://git.io/JG2bU | sudo bash
    
**remove_munki.sh**   
  removes munki install  
  curl https://raw.githubusercontent.com/jasonarias/2021onboarding/main/remove_munki.sh | sudo bash  
  curl -L https://git.io/JG2bC | sudo bash
    

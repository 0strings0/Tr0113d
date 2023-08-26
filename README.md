# Trolled - DLL Injection Exploit


Trolled is a powerful  DLL injector exploit designed to allow privilege escalation. It is meant to be used for windows 10/11. This project is meant as a bypass for school laptops and other locked devices given out by organizations. This exploit should not be used for any malicious or illegal means.

## How It Works

Trolled exploits a common vulnerability in certain systems that allows unauthorized escalation of privileges by tricking the system into running fake system dlls in a mock folder. Which the dll will then open a admin prompt to fool around in.

## How To Use
First we make a mock folder of Windows/System32. The mock folder has to have included the subdirectory in the command. 
#### Powershell Command
```
New-Item "\\?\C:\Windows \System32" -ItemType Directory
```

#### CMD Command
```
md "\\?\C:\Windows \System32"
```

After a fake Windows Folder should be made, open it from the C://, then go to System32 and copy over "computerdefualts.exe" then copy the .dll file named "profapi.dll" from stable releases or build it yourself from the instruction on how to do so later below. After, open "computerdefualts.exe" and boom a cmd prompt should open.


![Tro113d Thumbnail](https://i.ibb.co/sFNsfMp/trolledsnapshot.jpg)

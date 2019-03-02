# autoextractor
Automatically extract archives in your download folder - once. Extraction is done via p7zip - ```apt-get install p7zip-full p7zip-rar```.
Extracted archives are placed in a new folder each, so no worries about messed up folders. 

Caution: 7z is set to ```-y``` and COULD OVERWRITE edited files!

Clone it somewhere, use your automation tool of choice to run it on boot.

To run it on Windows with the WSL installed: 
Open Task Scheduler -> ```Create Task```\
  &nbsp;&nbsp;&nbsp;&nbsp;Name: Autoextractor\
  &nbsp;&nbsp;&nbsp;&nbsp;If you want the cmd to run in background (you probably do):\
  &nbsp;&nbsp;&nbsp;&nbsp;Security Options: run wether user is logged in or not, Do not store password \
  &nbsp;&nbsp;&nbsp;&nbsp;Triggers: ```On System Startup```\
  &nbsp;&nbsp;&nbsp;&nbsp;Action: ```cmd```\
  &nbsp;&nbsp;&nbsp;&nbsp;Param: ```/c "wsl /home/<username>/.autoextractor/autoextractor.sh &"```
  
Then right click -> run to directly start using it.

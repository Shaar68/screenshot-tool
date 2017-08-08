Screenshot tool created by Aetea (https://aetea.me)

A little bash script to capture and upload screenshots.

This script is very simple to use.
I use it with a keybinding in Gnome so that I can just press "Print Screen" on my keyboard and it will run.
I use the following command for the Gnome keybind: bash /home/aetea/.scripts/screenshot.sh aupc
It captures an area with the pointer included in the image and uploads it to my server. 

You can put all of your settings in a file named "settings.sh" (without quotes) next to the script.

You need to specify the path where the screenshots will end up.
You can specify the screenshot path by setting "SCREENSHOT_PATH" to your preferred directory.

For your information: When you upload an image the URL will get copied into your clipboard with xclip
For uploading functionality you need to set the following environment variables (you can set them in settings.sh):
  UPLOAD_HOST: The host of the SSH server. (example: vps.example.com)
  UPLOAD_USER: The SSH user for uploading. (example: upload-images)
  UPLOAD_PASS: The SSH user's password. (if this is not set the script will try to use a SSH key from $UPLOAD_KEY)
  UPLOAD_KEY: The SSH user's SSH key. (if this is also not set the script will try to use the default ssh key from the keyring)
  UPLOAD_PATH: The path on the server where the file should be uploaded. (example: /var/www)
  UPLOAD_URL: The URL-prefix to the images. (example: https://img.example.com/ would produce something like https://img.example.com/screenshot-2017-01-02_03-04-05.png)

Dependencies:
  gnome-screenshot
  sshpass (Only if you upload with password)
  xclip

Command Usage (Same as running the script with "help" (without quotes) as the only parameter):
  usage: screenshot.sh [options] [args...]
  options (name:description):
  a: capture area
  w: capture window
  i: interactive
  u: upload
  d <seconds>: delay for the specified amount of time before taking picture
  p: include the pointer
  b: include window border
  c: copy the link to the uploaded image to the clipboard
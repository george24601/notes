#show which processes are using a specified file, file system, or unix socket.
fuser -m -u /mnt/usb1

#check what processes are using a network port
fuser -v -n tcp 80

#view the port associated with a daemon
lsof -i -n -P | grep sendmail



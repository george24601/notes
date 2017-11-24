To tell systemd to start services automatically at boot, you must enable them
```
sudo systemctl enable application
```

Important [Service] Section Options
--------
1. Type. Default is simple, i.e., your ExecStart process IS the main service process
2. ExecStart. Specifies commands or scripts to be executed when the unit is started
3. Restart. the service is restarted after its process exits, with the exception of a clean stop by the systemctl command.

Sample Unit File
--------
```
[Unit]
Description=Postfix Mail Transport Agent
After=syslog.target network.target
Conflicts=sendmail.service exim.service

[Service]
Type=forking #your process is expected to do a fork() call
PIDFile=/var/spool/postfix/pid/master.pid
EnvironmentFile=-/etc/sysconfig/network
ExecStartPre=-/usr/libexec/postfix/aliasesdb
ExecStartPre=-/usr/libexec/postfix/chroot-update
ExecStart=/usr/sbin/postfix start
ExecReload=/usr/sbin/postfix reload
ExecStop=/usr/sbin/postfix stop
Restart=always
RestartSec=1
User=centos

[Install]
WantedBy=multi-user.target
```

why you should not run the service as root?

#Execute as root
```
chmod 664 /etc/systemd/system/name.service
```

Watch out for 
StartLimitBurst=5
StartLimitIntervalSec=10
because systemd gives up restarting your service if it fails to start more than 5 times within a 10 seconds interval

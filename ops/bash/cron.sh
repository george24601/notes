#edit, -l to list
crontab -e

#3am job every day, pipe yes "y" to answer questions
0 3 * * * docker system prune -a 1> /home/ec2-user/cron.log  2> /home/ec2-user/cron.err 

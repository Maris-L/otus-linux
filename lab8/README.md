# Домашнее задание №8

Systemd  
Цель: Управление автозагрузкой сервисов происходит через systemd. Вместо cron'а тоже используется systemd. И много других возможностей. В ДЗ нужно написать свой systemd-unit.  

1. Написать сервис, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова. Файл и слово должны задаваться в /etc/sysconfig:  
	* watchlog [здесь](watchlog)  
	* таймер [здесь](watchlog.timer)  
	* log [здесь](watchlog.log)  
	* скрипт [здесь](watchlog.log)  
	* сервис [здесь](watchlog.service)  

```
[root@otuslinux ~]# systemctl status watchlog.timer
● watchlog.timer - Run watchlog script every 30 second
   Loaded: loaded (/etc/systemd/system/watchlog.timer; enabled; vendor preset: disabled)
  Active: active (elapsed) since Sun 2019-12-29 09:00:00 UTC; 1min 14s ago
[root@otuslinux ~]# systemctl status watchlog
● watchlog.service - My watchlog service
   Loaded: loaded (/usr/lib/systemd/system/watchlog.service; static; vendor preset: disabled)
   Active: activating (start) since Sun 2019-12-29 09:04:11 UTC; 8ms ago
 Main PID: 2961 (systemd)
   CGroup: /system.slice/watchlog.service
           └─2961 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
  
Dec 29 09:04:11 otuslinux systemd[1]: Starting My watchlog service...

Dec 29 09:04:11 otuslinux systemd: Starting My watchlog service...
Dec 29 09:04:11 otuslinux root: Sun Dec 29 09:04:11 UTC 2019: I found word, Master
Dec 29 09:04:11 otuslinux systemd: Started My watchlog service.
Dec 29 09:05:28 otuslinux systemd: Starting My watchlog service...
Dec 29 09:05:28 otuslinux root: Sun Dec 29 09:05:28 UTC 2019: I found word, Master
Dec 29 09:05:28 otuslinux systemd: Started My watchlog service.
```
  
2. Из epel установить spawn-fcgi и переписать init-скрипт на unit-файл. Имя сервиса должно так же называться.  
    * yum install spawn-fcgi -y  
    * spawn-fcgi [здесь](spawn-fcgi)  
    * spawn-fcgi.service [здесь](spawn-fcgi.service)  
  
3. Дополнить юнит-файл apache httpd возможностью запустить несколько инстансов сервера с разными конфигами  
    * unitfile [здесь](httpd@.service)  
    * instance1 [здесь](httpd-instance1.conf) и [здесь](httpd-instance1) на 80 порту  
    * instance2 [здесь](httpd-instance2.conf) и [здесь](httpd-instance2) на 8080 порту   
    * для проверки соответственно исправлены index.html каждого сайта [instance1](index.html)  
  
```
[root@otuslinux html]# curl -l localhost:80
<h1>Instance 1</h1>

Web site 1
[root@otuslinux html]# curl -l localhost:8080  
<h1>Instance 2</h1>

Web site 2

[root@otuslinux run]# more /var/run/httpd_instance1.pid
4766
[root@otuslinux run]# more /var/run/httpd_instance2.pid
4779
[root@otuslinux ~]# ss -tulnp |grep httpd
tcp    LISTEN     0      128      :::8080                 :::*                   users:(("httpd",pid=4785,fd=4),("httpd",pid=4784,fd=4),("httpd",pid=4783,fd=4),("httpd",pid=4782,fd=4),("httpd",pid=4781,fd=4),("httpd",pid=4780,fd=4),("httpd",pid=4779,fd=4))
tcp    LISTEN     0      128      :::80                   :::*                   users:(("httpd",pid=4772,fd=4),("httpd",pid=4771,fd=4),("httpd",pid=4770,fd=4),("httpd",pid=4769,fd=4),("httpd",pid=4768,fd=4),("httpd",pid=4767,fd=4),("httpd",pid=4766,fd=4))
[root@otuslinux ~]#
[root@otuslinux ~]# ps -aux |grep httpd
root      4766  0.2  1.3 313824 13240 ?        Ss   16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4767  0.0  0.3 265156  3804 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4768  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4769  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4770  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4771  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
apache    4772  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance1.conf -DFOREGROUND
root      4779  0.2  1.3 313824 13240 ?        Ss   16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4780  0.0  0.3 265156  3808 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4781  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4782  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4783  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4784  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
apache    4785  0.0  0.6 313960  6164 ?        S    16:56   0:00 /usr/sbin/httpd -f /etc/httpd/conf/httpd-instance2.conf -DFOREGROUND
root      4808  0.0  0.0  12520   984 pts/0    S+   16:58   0:00 grep --color=auto httpd
[root@otuslinux ~]#
```

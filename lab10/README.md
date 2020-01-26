# Домашнее задание №10

1. Запретить всем пользователям, кроме группы admin логин в выходные(суббота и воскресенье), без учета праздников
    * создадим 3х пользователей:
	```
	useradd day && \ sudo useradd night && \sudo useradd friday
	echo "Otus2019"|sudo passwd --stdin day &&\echo "Otus2019" | sudo passwd --stdin night  &&\echo "Otus2019" | sudo passwd --stdin friday
	```
	Правим sshd_config:  
	```
	sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config
	systemctl restart sshd.service
	```
* соответственно добавляем /etc/security/time.conf
	```
	*;*;day;Al0800-2000
	*;*;night;!Al0800-2000
	*;*;friday;Fr
	```
* соответственно правим /etc/pam.d/[sshd](sshd)
	`account    required     pam_time.so`
* второй способ:
	и правим /etc/pam.d/sshd на	
	`account  required   pam_exec.so  /usr/local/bin/test_login.sh` (скрипт [test_login.sh](test_login.sh))
* третий способ:  
	`yum install epel-release -y && yum install pam_script -y`  
	и правим /etc/pam.d/sshd на  
	`account  required  pam_script.so  /usr/local/bin/test_login.sh`
2. Дать конкретному пользователю права рута  
    * добавляем в группу wheel:  
	`usermod -G wheel day`  
    * добавляем в sudoers:  
	`day        ALL=(ALL)       NOPASSWD: ALL` [sudoers](sudoers)

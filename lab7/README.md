# Домашнее задание №7

1. Попасть в систему без пароля несколькими способами (в virtualbox вагрант centos/7 образе не удалось запустить, запускал с vagrant образа rhel7 (смотреть Vagrantfile):  
    * Метод 1:  
	изменить в запуске `ro` на `rw init=/sysroot/bin/sh`  
	смотреть [здесь](boot1.png)  
	запуск и смена пароля [здесь](boot2.png)  
* Метод 2:  
	дополнить в запуске `rd.break`  
	смотреть [здесь](boot3.png)  
	запуск и смена пароля [здесь](boot4.png)  
* Метод 3:  
	дополнить в запуске `init=/bin/sh`  
	смотреть [здесь](boot5.png)  
	запуск и смена пароля [здесь](boot6.png)  
P.S. На RHEL7 надо исправить в `/etc/ssh/sshd_config` `#PermitRootLogin yes` на `PermitRootLogin no`
2. Установить систему с LVM, после чего переименовать VG:
    * Смотрим vgs, делаем vgrename:  
    `vgrename VolGroup00 lab7`  
    * Правим /etc/fstab, /etc/default/grub, /boot/grub2/grub.cfg:  
    `sed -i 's/centos/lab7/' /etc/fstab`  
    `sed -i 's/centos/lab7/g' /etc/default/grub`  
    `sed 's/centos/lab7/g' /boot/grub2/grub.cfg -i`  
    * Пересоздаем initrd image:  
    `mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r)`  
    * Перегружаемся и смотрим vgs  
3. Добавить модуль в initrd:
    * Создаем папку `mkdir /usr/lib/dracut/modules.d/01test`, кидаем туда скрипты module-setup.sh и test.sh
    * Пересобираем initrd:
    `dracut -f -v`
* Проверяем модуль test:
`lsinitrd -m /boot/initramfs-$(uname -r).img | grep test`
* Перегружаемся и смотрим [результат](test-module.png)
---
Загрузка [CentOS](virtualbox-centos7.PNG), Vagrantfile [здесь](Vagrantfile)  
Boot screen-ы [Метод 1](boot1.png) [Метод 1](boot2.png) [Метод 2](boot3.png) [Метод 2](boot4.png) [Метод 3](boot5.png) [Метод 3](boot6.png)  
Тест модуля [initrd](test-module.png) 
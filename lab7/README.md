# Домашнее задание №7

1. Попасть в систему без пароля несколькими способами (в virtualbox6.0/Win10/Vagrant2.2.6 centos/7 образ не удалось запустить (см. [CentOS](virtualbox-centos7.PNG), запускал с vagrant образа rhel7 (смотреть [Vagrantfile](Vagrantfile))):  
    * Метод 1:  
	изменить в запуске `ro` на `rw init=/sysroot/bin/sh`  
	![method1](boot1.png)  
	запуск и смена пароля 
    ![method1_2](boot2.png)  
    * Метод 2:  
	дополнить в запуске `rd.break`  
	![method2](boot3.png)  
	запуск и смена пароля  
    ![method2_2](boot4.png)  
    * Метод 3:  
	дополнить в запуске `init=/bin/sh`  
	![method3](boot5.png)  
	запуск и смена пароля  
    ![method3_2](boot6.png)  
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
* Перегружаемся и смотрим  
![результат](test-module.png)
---
Загрузка [CentOS](virtualbox-centos7.PNG), Vagrantfile [здесь](Vagrantfile)  
Boot screen-ы [Метод 1](boot1.png) [Метод 1](boot2.png) [Метод 2](boot3.png) [Метод 2](boot4.png) [Метод 3](boot5.png) [Метод 3](boot6.png)  
Тест модуля [initrd](test-module.png) 
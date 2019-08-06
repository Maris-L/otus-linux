# Домашнее задание №1

1. Установил wget и скачал актуальную kernel версию с kernel.org
* `yum install wget`
* `wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.2.5.tar.xz`
2. Распаковал kernel следующими командами
* `unxz -v linux-5.2.5.tar.xz`
* `tar xvf linux-5.2.5.tar`
3. Скопировал конфиг файл в директорию с kernel инсталяцией
* `cp -v /boot/config-3.10.0-957.12.2.el7.x86_64 .config`
4. Установил "Development Tools" группу с компилятором
* `yum group install "Development Tools"`
5. Доустановил нехватающих компонентов
* `yum install openssl-devel ncurses-devel elfutils-libelf-devel`
6. Запустил ради интереса menuconfig, конифгурацию неизменял
* `make menuconfig`
7. Запустил компиляцию kernel на две cores
* `make -j 2`
* ответы на все вопросы по default
8. Прочитал ошибку, доустановил нехватающую компоненту bc
* `yum install bc`
9. Запустил компиляцию kernel заново
* `make -j 2`
10. Дождался результата (около 1,5 часа) и установил модули
* `make modules_install`
11. Сделал инсталляцию и изменил grub для запуска
* `make install`
* `grub2-mkconfig -o /boot/grub2/grub.cfg`
12. Перезапустил, но, как оказалось, со старым kernel
* `reboot`
* `uname -a`
13. Изменил, чтобы новый kernel грузился как default и перезагрузил вм
* `grubby --set-default /boot/vmlinuz-5.2.5`
* `reboot`
14. После загрузки посмотрел, с каким kernel грузится вм
* `uname -a`
Linux otuslinux 5.2.5 #1 SMP Thu Aug 1 10:37:02 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
* `cat /proc/version`
Linux version 5.2.5 (root@otuslinux) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-36) (GCC)) #1 SMP Thu Aug 1 10:37:02 UTC 2019

---
yum история [здесь](yum.log) 
config файл [здесь](.config)
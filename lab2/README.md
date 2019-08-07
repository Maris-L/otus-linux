# Домашнее задание №2

1. Для выполнения домашнего задания требовалось создать RAID, я выбрал RAID5:
* `mdadm --create /dev/md0 --level 5 -n 6 /dev/sd{b,c,d,e,f,g}`
2. Проверка RAID массива:
* `cat /proc/mdstat`
* `mdadm -D /dev/md0`
3. Инсталлируем lvm и создаем physical volume:
* `yum install lvm2`
* `pvcreate /dev/md0`
4. Ломаем RAID:
* `mdadm /dev/md0 --set-faulty /dev/sdg`
* `mdadm /dev/md0 --remove /dev/sdg`
5. Смотрим статус RAIDa:
* `mdadm -D /dev/md0`
* `cat /proc/mdstat`
6. RAID degraded, добавляем диск:
* `mdadm /dev/md0 --add /dev/sdg`
7. Смотрим статус RAIDa, пока resync готов:
* `mdadm -D /dev/md0`
8. Проверяем RAID:
* `mdadm -D /dev/md0`
* `cat /proc/mdstat`
9. Создаем одинаковых 5 партиции на gpt на весь RAID диск:
* `parted`
	* `mktable gpt`
	* `mkpart P1 0% 20%`
	* `mkpart P2 20% 40%`
	* `mkpart P1 40% 60%`
	* `mkpart P1 60% 80%`
	* `mkpart P1 80% 100%`
* `p` смотрим результат
---
Vagrantfile [здесь](Vagrantfile) 
Скрипт для RAID отдельно [здесь](raid.sh)
Скрипт для parted отдельно [здесь](partitions.sh)
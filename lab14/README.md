# Домашнее задание №14

Настраиваем бэкапы  
Настроить стенд Vagrant с двумя виртуальными машинами server и client.

Настроить политику бэкапа директории /etc с клиента:  
    1) Полный бэкап - раз в день  
    2) Инкрементальный - каждые 10 минут  
    3) Дифференциальный - каждые 30 минут  
  
Запустить систему на два часа. Для сдачи ДЗ приложить list jobs, list files jobid=<id> и сами конфиги bacula-*

Разворачиваем стенд по [Vagrantfile](Vagrantfile) и правим соотвествующих конфиги файлов [Bacula File Daemon](bacula-fd.conf), [Bacula Storage Daemon](bacula-sd.conf) и [Bacula Director](bacula-dir.conf), делаем проверку всех конфигурации командами `bacula-dir -tc bacula-dir.conf` `bacula-fd tc bacula-fd.conf` `bacula-sd -tc bacula-sd.conf`, запускаем на пару часов и смотрим вывод команд в bconsole:

[list jobs](list-jobs.txt)  
list files [jobid=1](jobid1.txt) и [jobid=2](jobid2.txt)  
правим пару файлов и смотрим [list files](list-files-jobid.txt)  

Компрессия файлов (см. соотв. раздел в [Bacula Director](bacula-dir.conf)):
```
	FileSet {
  Name = "CentOS Configs"
  Include {
    Options {
      signature = MD5
      compression = GZIP
```

---
Файлы:  
Vagrantfile [здесь](Vagrantfile)  
[Bacula File Daemon](bacula-fd.conf)  
[Bacula Storage Daemon](bacula-sd.conf)  
[Bacula Director](bacula-dir.conf)  
[Bconsole](bconsole.conf)  
[list jobs](list-jobs.txt)  
[list files jobid=1](jobid1.txt)  
[list files jobid=2](jobid2.txt)  
list files [incremental](list-files-jobid.txt)  
[messages](bconsole-messages.txt) и [статус](stat-client2.txt)
 
# Домашнее задание №9

Домашнее задание Первые шаги с Ansible Подготовить стенд на Vagrant как минимум с одним сервером. На этом сервере используя Ansible необходимо развернуть nginx со следующими условиями:

   * необходимо использовать модуль yum/apt
   * конфигурационные файлы должны быть взяты из шаблона jinja2 с перемененными
   * после установки nginx должен быть в режиме enabled в systemd
   * должен быть использован notify для старта nginx после установки
   * сайт должен слушать на нестандартном порту - 8080, для этого использовать переменные в Ansible
   * Сделать все это с использованием Ansible роли

Стенд поднимался на 2 машинах (см. Vagrantfile [здесь](Vagrantfile)):

   * otuslinux машина - ansible управление
   * nginx машина - сервер, куда развернут nginx

С машины управления otuslinux проверяем доступ на nginx машину, устанавливаем python и ansible:
```
sed -i -e "\$a192.168.11.150 nginx" /etc/hosts
yum install python -y && yum install ansible -y
```
Создаем hosts файл, проверяем управление и правим ansible.cfg:

```
nginx ansible_host=nginx ansible_port=22 ansible_user=vagrant ansible_private_key_file=.vagrant/machines/nginx/virtualbox/private_key
```

```
[root@otuslinux ansible]# ansible nginx -i staging/hosts -m ping  
nginx | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
```

```
[defaults]
inventory = staging/hosts
remote_user = vagrant
host_key_checking = False
retry_files_enabled = False
```

Создаем соответствующий [nginx.yml](nginx.yml) и запускаем:
```
ansible-playbook nginx.yml

PLAY [NGINX | Install and configure NGINX] ***************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************
ok: [nginx]

TASK [NGINX | Install EPEL Repo package from standart repo] **********************************************************************
ok: [nginx]

TASK [NGINX | Install NGINX package from EPEL Repo] ******************************************************************************
ok: [nginx]

TASK [NGINX | Create NGINX config file from template] ****************************************************************************
changed: [nginx]

RUNNING HANDLER [reload nginx] ***************************************************************************************************
changed: [nginx]

PLAY RECAP ***********************************************************************************************************************
nginx                      : ok=5    changed=2    unreachable=0    failed=0   
```
Проверка:
```
curl http://nginx:8080
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>Welcome to CentOS</title>
  <style rel="stylesheet" type="text/css">
```
---
Соответствующие файлы:
nginx.conf.j2 [здесь](nginx.conf.j2)
hosts [здесь](hosts)
nginx.yml [здесь](nginx.yml)
Vagrantfile [здесь](Vagrantfile)
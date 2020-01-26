# Домашнее задание №7

1. Для выполнения домашнего задания устанавливаем пакеты:

`yum install redhat-lsb-core wget rpmdevtoools rpm-build createrepo yum-utils gcc openssl-devel elinks -y`

2. Скачиваем SRPM пакеты (+например более новый TMUX в дополнение):

`wget https://nginx.org/packages/centos/7/SRPMS/nginx-1.16.1-1.el7.ngx.src.rpm`  
`https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Everything/source/tree/Packages/t/tmux-3.0a-1.fc32.src.rpm`

3. Создаем структуру каталогов:

`rpm -i nginx-1.16.1-1.el7.ngx.src.rpm`  
`rpm -i tmux-3.0a-1.fc32.src.rpm`

4. Скачиваем openssl и распаковываем:

`wget https://www.openssl.org/source/latest.tar.gz`  
`tar -xvf latest.tar.gz`

5. Правим nginx.spec:

`sed -i 's|--with-debug|--with-openssl=/usr/lib/openssl-1.1.1d|' /root/rpmbuild/SPECS/nginx.spec`  

6. Устанавливаем dependencies:

`yum-builddep rpmbuild/SPECS/nginx.spec -y`  
`yum-builddep rpmbuild/SPECS/tmux.spec -y`

7. Собираем пакеты:

`rpmbuild -bb rpmbuild/SPECS/nginx.spec`  
`rpmbuild -bb rpmbuild/SPECS/tmux.spec`

7. Инсталируем nginx и конфигурируем:

`yum localinstall -y /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7_4.ngx.x86_64.rpm`  
`sed -i '/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf`

8. Влкючаем и запускаем nginx:

`systemctl enable nginx`  
`systemctl start nginx`

9. Создаем каталог для репозитория и копируем туда свои RPMы:

`mkdir /usr/share/nginx/html/repo`  
`cp /root/rpmbuild/RPMS/x86_64/nginx-1.16.1-1.el7_4.ngx.x86_64.rpm /usr/share/nginx/html/repo/`  
`cp /root/rpmbuild/RPMS/x86_64/tmux-3.0a-1.el7.x86_64.rpm /usr/share/nginx/html/repo/`  

10. Инициализируем репозиторий и добавляем autoindex:

`createrepo /usr/share/nginx/html/repo/`  
`sed -i '/index  index.html index.htm;/a autoindex on;' /etc/nginx/conf.d/default.conf`  
`systemctl reload nginx`

11. Проверяем результат:

`nginx -t`  
`nginx -s reload`  
`elinks http://localhost/repo/`

12. Добавляем репозитории и проверяем установку с репозитория:

`cat >> /etc/yum.repos.d/otus.repo << EOF`  
	`[lab6]`  
	`name=lab6`  
	`baseurl=http://localhost/repo`  
	`gpgcheck=0`  
	`enabled=1`  
	`EOF`  
`yum list |grep lab6`  
`yum install tmux -y`  

13. Запускаем tmux и проверяем работоспособность

---
Vagrantfile [здесь](Vagrantfile)  
TMUX rpm [здесь](tmux-3.0a-1.el7.x86_64.rpm)
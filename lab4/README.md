# Домашнее задание №4

Пишем скрипт написать скрипт для крона который раз в час присылает на заданную почту

	X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
	Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
	все ошибки c момента последнего запуска
	список всех кодов возврата с указанием их кол-ва с момента последнего запуска в письме должно быть прописан обрабатываемый временной диапазон должна быть реализована защита от мультизапуска Критерии оценки: трапы и функции, а также sed и find +1 балл

Результат:

скрипт [здесь](logparser.sh)
crontab [здесь](prepare.sh)
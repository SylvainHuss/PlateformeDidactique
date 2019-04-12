backup:
	docker exec db /usr/bin/mysqldump -u root --password=mdp bd > ./bd/files/backup.sql

restore:
	cat ./bd/files/backup.sql | docker exec -i db /usr/bin/mysql -u root --password=mdp bd

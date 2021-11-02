# devops-netology


    1. 
    	Server version:		8.0.27 MySQL Community Server - GPL

		+----+----------------+-------+
		| id | title          | price |
		+----+----------------+-------+
		|  2 | My little pony |   500 |
		+----+----------------+-------+
		1 row in set (0.01 sec)

  	2.
  		mysql> select user, host, password_lifetime, max_questions, plugin from mysql.user where user = 'test';
		+------+-----------+-------------------+---------------+-----------------------+
		| user | host      | password_lifetime | max_questions | plugin                |
		+------+-----------+-------------------+---------------+-----------------------+
		| test | localhost |               180 |           100 | mysql_native_password |
		+------+-----------+-------------------+---------------+-----------------------+
		1 row in set (0.00 sec)

		mysql> select User_attributes from mysql.user where user = 'test';
		+-------------------------------------------------------------------------------------------------------------------------------------+
		| User_attributes                                                                                                                     |
		+-------------------------------------------------------------------------------------------------------------------------------------+
		| {"metadata": {"fname": "James", "lname": "Pretty"}, "Password_locking": {"failed_login_attempts": 3, "password_lock_time_days": 0}} |
		+-------------------------------------------------------------------------------------------------------------------------------------+
		1 row in set (0.00 sec)

	3.
		Исследуйте, какой engine используется в таблице БД test_db и приведите в ответе.

		SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'test_db';
		+------------+--------+
		| TABLE_NAME | ENGINE |
		+------------+--------+
		| orders     | InnoDB |
		+------------+--------+
		1 row in set (0.00 sec)

		Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:

		mysql> ALTER TABLE orders ENGINE = MyISAM;
		Query OK, 5 rows affected (0.86 sec)
		Records: 5  Duplicates: 0  Warnings: 0

		mysql> ALTER TABLE orders ENGINE = InnoDB;
		Query OK, 5 rows affected (1.15 sec)
		Records: 5  Duplicates: 0  Warnings: 0

	4.
		[mysqld]
		pid-file        = /var/run/mysqld/mysqld.pid
		socket          = /var/run/mysqld/mysqld.sock
		datadir         = /var/lib/mysql
		secure-file-priv= NULL

		innodb_flush_method = O_DSYNC
		innodb_flush_log_at_trx_commit = 2
		innodb_file_per_table = 1
		innodb_log_buffer_size = 1M
		innodb_buffer_pool_size = 2300M
		innodb_log_file_size = 100M

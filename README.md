# devops-netology


    1. 
    	docker run -d -e POSTGRES_PASSWORD='\' -v /home/alex/Desktop/Netology/6.2/data:/var/lib/postgresql/data -v /home/alex/Desktop/Netology/6.2/backup:/opt/backup postgres:12

    2. 
    	итоговый список БД после выполнения пунктов выше

	    	test_db=# \l
	                                     List of databases
			   Name    |  Owner   | Encoding |  Collate   |   Ctype    |       Access privileges        
			-----------+----------+----------+------------+------------+--------------------------------
			 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 | 
			 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
			           |          |          |            |            | postgres=CTc/postgres
			 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres                   +
			           |          |          |            |            | postgres=CTc/postgres
			 test_db   | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =Tc/postgres                  +
			           |          |          |            |            | postgres=CTc/postgres         +
			           |          |          |            |            | "test-admin-user"=CTc/postgres
			(4 rows)
	    
	    описание таблиц (describe)
	    
	    	test_db=# \d+ orders
	                                                          Table "public.orders"
		    Column    |         Type          | Collation | Nullable |              Default               | Storage  | Stats target | Description 
		--------------+-----------------------+-----------+----------+------------------------------------+----------+--------------+-------------
		 id           | integer               |           | not null | nextval('orders_id_seq'::regclass) | plain    |              | 
		 Наименование | character varying(10) |           |          |                                    | extended |              | 
		 цена         | integer               |           |          |                                    | plain    |              | 
		Indexes:
		    "orders_pkey" PRIMARY KEY, btree (id)
		Referenced by:
		    TABLE "clients" CONSTRAINT "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
		Access method: heap

			test_db=# \d+ clients
	                                                         Table "public.clients"
		      Column       |     Type      | Collation | Nullable |               Default               | Storage  | Stats target | Description 
		-------------------+---------------+-----------+----------+-------------------------------------+----------+--------------+-------------
		 id                | integer       |           | not null | nextval('clients_id_seq'::regclass) | plain    |              | 
		 фамилия           | character(30) |           |          |                                     | extended |              | 
		 страна проживания | character(30) |           |          |                                     | extended |              | 
		 заказ             | integer       |           |          |                                     | plain    |              | 
		Indexes:
		    "clients_pkey" PRIMARY KEY, btree (id)
		    "country" btree ("страна проживания")
		Foreign-key constraints:
		    "clients_заказ_fkey" FOREIGN KEY ("заказ") REFERENCES orders(id)
		Access method: heap

		SQL-запрос для выдачи списка пользователей с правами над таблицами test_db
	    	
	    	select * from information_schema.table_privileges where grantee != 'postgres' AND table_schema = 'public';
	    
	    список пользователей с правами над таблицами test_db

	    test_db=# select * from information_schema.table_privileges where grantee != 'postgres' AND table_schema = 'public';

		 grantor  |     grantee      | table_catalog | table_schema | table_name | privilege_type | is_grantable | with_hierarchy 
		----------+------------------+---------------+--------------+------------+----------------+--------------+----------------
		 postgres | test-admin-user  | test_db       | public       | orders     | INSERT         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | orders     | UPDATE         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | orders     | DELETE         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | orders     | TRUNCATE       | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | orders     | REFERENCES     | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | orders     | TRIGGER        | NO           | NO
		 postgres | test-simple-user | test_db       | public       | orders     | INSERT         | NO           | NO
		 postgres | test-simple-user | test_db       | public       | orders     | SELECT         | NO           | YES
		 postgres | test-simple-user | test_db       | public       | orders     | UPDATE         | NO           | NO
		 postgres | test-simple-user | test_db       | public       | orders     | DELETE         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | INSERT         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | UPDATE         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | DELETE         | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | TRUNCATE       | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | REFERENCES     | NO           | NO
		 postgres | test-admin-user  | test_db       | public       | clients    | TRIGGER        | NO           | NO
		 postgres | test-simple-user | test_db       | public       | clients    | INSERT         | NO           | NO
		 postgres | test-simple-user | test_db       | public       | clients    | SELECT         | NO           | YES
		 postgres | test-simple-user | test_db       | public       | clients    | UPDATE         | NO           | NO
		 postgres | test-simple-user | test_db       | public       | clients    | DELETE         | NO           | NO
		(20 rows)

	3.
		вычислите количество записей для каждой таблицы
			
			test_db=# SELECT COUNT(*) FROM orders;
			 count 
			-------
			     5
			(1 row)

			test_db=# SELECT COUNT(*) FROM clients;
			 count 
			-------
			     5
			(1 row)

	4.
		UPDATE clients SET заказ = 3 WHERE id = 1 ;
		UPDATE clients SET заказ = 4 WHERE id = 2 ;
		UPDATE clients SET заказ = 5 WHERE id = 3 ;

		test_db=# SELECT DISTINCT c.фамилия, o.Наименование
		FROM clients AS c INNER JOIN orders AS o ON (c.заказ = o.id);

		            фамилия             | Наименование 
		--------------------------------+--------------
		 Петров Петр Петрович           | Монитор
		 Иванов Иван Иванович           | Книга
		 Иоганн Себастьян Бах           | Гитара
		(3 rows)

	5.
		test_db=# EXPLAIN SELECT c.фамилия, o.Наименование
                FROM clients AS c INNER JOIN orders AS o ON (c.заказ = o.id);
                              
                               QUERY PLAN                                
		-------------------------------------------------------------------------
		 Hash Join  (cost=34.75..48.28 rows=280 width=162)
		   Hash Cond: (c."заказ" = o.id)
		   ->  Seq Scan on clients c  (cost=0.00..12.80 rows=280 width=128)
		   ->  Hash  (cost=21.00..21.00 rows=1100 width=42)
		         ->  Seq Scan on orders o  (cost=0.00..21.00 rows=1100 width=42)

		Сначала просматривается таблица orders (Seq Scan on orders), для каждой ее строки вычисляется хэш (Hash).
		Далее для таблицы clients также вычисляется хэш и сравнивается (Hash Join) с хэшем таблицы orders по
		условию (Hash Cond).

	6.
		для бэкапа
		pg_dump -U postgres test_db > /opt/backup/test_db.dump

		для восстановления
		createdb -U postgres test_db
		createuser -U postgres test-admin-user
		createuser -U postgres test-simple-user
		psql -U postgres -d test_db < /opt/backup/test_db.dump
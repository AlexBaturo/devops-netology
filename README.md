# devops-netology


    1. 
    	вывода списка БД - \l
		подключения к БД - \c database_name
		вывода списка таблиц \dt 
		вывода описания содержимого таблиц \d+ 
		выхода из psql \q

  	2.	
		Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.
		Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.
		
		select attname from pg_stats where tablename = 'orders' and avg_width = ( select MAX(avg_width) from pg_stats where tablename = 'orders' ) ;

		 attname 
		---------
		 title
		(1 row)

	3.
		ALTER TABLE orders RENAME TO orders_backup;

		CREATE TABLE orders (LIKE orders_backup INCLUDING ALL);

		create table orders_1 (LIKE orders INCLUDING ALL, check ( price>499 ) ) inherits (orders);
		create table orders_2 (LIKE orders INCLUDING ALL, check ( price<=499 ) ) inherits (orders);

		create rule orders_insert_to_1 as on insert to orders
		where ( price>499)
		do instead insert into orders_1 values(NEW.*);

		create rule orders_insert_to_2 as on insert to orders
		where ( price<=499)
		do instead insert into orders_2 values(NEW.*);

		insert into orders (id, title, price)
		select id, title, price from orders_backup;

		drop table orders_backup cascade;

		Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?
		Да, если если бы действия, приведенные выше, были бы проделаны заранее, до начала использования таблицы.

	4.
		CREATE UNIQUE INDEX orders_1_title_idx ON public.orders_1 USING btree (title);	
		CREATE UNIQUE INDEX orders_2_title_idx ON public.orders_2 USING btree (title);
		CREATE UNIQUE INDEX orders_title ON public.orders USING btree (title);

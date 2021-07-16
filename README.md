# devops-netology


    1. 
    	c=a+b результатом является строка
    	d=1+2 результатом является строка, но вместо a и b поставлены их значения
    	e=3   результатом является результат выполнения суммирования значений a и b благодаря двойным скобкам, которые
    		  позволяют выполнить арифметическое действие со значениями переменных

    2. 	while ((1==1))
		do
		curl http://localhost:8080
		if (($? != 0))
		then
		date >> curl.log
		else
		break
		fi
		done

    
    3. 
		#!/usr/bin/env bash

		arrayIp=("192.168.0.1" "173.194.222.113"  "87.250.250.242")
		port=80

		for ip in ${arrayIp[@]}
		do
			for number in {0..4}
			do
				nc -zvw3 $ip $port 2>>log
			done
		done

        
    4. 
		#!/usr/bin/env bash

		arrayIp=("192.168.0.1" "173.194.222.113"  "87.250.250.242")
		port=80

		while ((1==1))
		do
			for ip in ${arrayIp[@]}
			do
				for number in {0..4}
				do
					nc -zvw3 $ip $port 2>> log
					if (($? != 0))
					then
						echo $ip >> error
						exit 0
					fi
				done
			done
		done

    5.
		#!/usr/bin/env bash

		commitFile=$1
		pattern='\[([[:digit:]]+)-([[:alpha:]]+)-([[:digit:]]+)-([[:alpha:]]+)\].*'

		commitMessage=$(grep -E "$pattern" "$commitFile")

		if ! ([ $? -eq 0 ] && [ $(($(echo $commitMessage | wc -m))) -le 30 ]) ; then
		    echo "Wrong format"
		    exit 1
		fi




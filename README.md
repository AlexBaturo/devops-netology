# devops-netology


    1. 
    	Какое значение будет присвоено переменной c?
    		TypeError: unsupported operand type(s) for +: 'int' and 'str'

    	Как получить для переменной c значение 12?
    		c = str(a) + b

    	Как получить для переменной c значение 3?
    		c = a + int(b)

    2. 	#!/usr/bin/env python3

		import os

		repo_dir =  "~/netology/sysadm-homeworks/"

		bash_command = ["cd {}".format(repo_dir), "git status"]
		result_os = os.popen(' && '.join(bash_command)).read()
		is_change = False
		for result in result_os.split('\n'):
		    if result.find('modified') != -1:
		        prepare_result = result.replace('\tmodified:   ', '')
		        print(repo_dir + prepare_result)

    
    3. 
		#!/usr/bin/env python3

		import os
		import sys

		if len(sys.argv) > 1:
		    repo_dir = sys.argv[1]
		else:
		    repo_dir =  "~/netology/sysadm-homeworks/"

		bash_command = ["cd {}".format(repo_dir), "git status"]
		result_os = os.popen(' && '.join(bash_command)).read()
		is_change = False
		for result in result_os.split('\n'):
		    if result.find('modified') != -1:
		        prepare_result = result.replace('\tmodified:   ', '')
		        print(repo_dir + prepare_result)

        
    4. 
		#!/usr/bin/env python3

		import socket
		import time

		urlList = ["drive.google.com", "mail.google.com", "google.com"]
		lastIpList = [socket.gethostbyname(url) for url in urlList]

		while(1>0):
		    for i in range(len(urlList)):

		        currentIp = socket.gethostbyname(urlList[i])

		        if lastIpList[i] != currentIp:
		            print ("[ERROR] {0} IP mismatch: {1} {2}".format(urlList[i], lastIpList[i], currentIp))
		        else:
		            print ("{0} - {1}".format(urlList[i],socket.gethostbyname(urlList[i])))

		        lastIpList[i] = currentIp
		    print('\n')
		    time.sleep(1)

    5.
		#!/usr/bin/env bash

		commitFile=$1
		pattern='\[([[:digit:]]+)-([[:alpha:]]+)-([[:digit:]]+)-([[:alpha:]]+)\].*'

		commitMessage=$(grep -E "$pattern" "$commitFile")

		if ! ([ $? -eq 0 ] && [ $(($(echo $commitMessage | wc -m))) -le 30 ]) ; then
		    echo "Wrong format"
		    exit 1
		fi




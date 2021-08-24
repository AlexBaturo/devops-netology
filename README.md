# devops-netology


    1. 
    	Какое значение будет присвоено переменной c?
    		TypeError: unsupported operand type(s) for +: 'int' and 'str'

    	Как получить для переменной c значение 12?
    		c = str(a) + b

    	Как получить для переменной c значение 3?
    		c = a + int(b)

    2. 	
```python
#!/usr/bin/env python3

import os

repo_dir =  "~/netology/sysadm-homeworks/"

bash_command = ["cd {}".format(repo_dir), "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
	prepare_result = result.replace('\tmodified:   ', '')
	print(repo_dir + prepare_result)
```

    
    3. 
```python
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
```

        
    4. 
``` python   
#!/usr/bin/env python3

import socket
import time

urlList = ["drive.google.com", "mail.google.com", "google.com"]
lastIpList = [socket.gethostbyname(url) for url in urlList]

while True:
    for i in range(len(urlList)):

	currentIp = socket.gethostbyname(urlList[i])

	if lastIpList[i] != currentIp:
	    print ("[ERROR] {0} IP mismatch: {1} {2}".format(urlList[i], lastIpList[i], currentIp))
	else:
	    print ("{0} - {1}".format(urlList[i],socket.gethostbyname(urlList[i])))

	lastIpList[i] = currentIp
    print('\n')
    time.sleep(1)
```
    5.
```python
#!/usr/bin/env python3

import json
import os
import requests
import sys

class GithubApi:
    def __init__(self, url, user, token):
	self.url = url
	self.user = user
	self.token = token
	self.header = {"Accept" : "application/vnd.github.v3+json"}
	self.prefix = '{0}/repos/{1}'.format(self.url, self.user)

    def commitPush(self, workBranch, repo, message):

	# Получаем ссылку на последний коммит
	ref = requests.get('{0}/{1}/git/matching-refs/heads/{2}'.format(self.prefix, repo, workBranch), 
			     auth=(self.user, self.token),
			     headers=self.header)

	# Получаем хэш последнего коммита
	try:
	    shaHead = ref.json()[0]['object']['sha']
	except KeyError:
	    print("Проверить валидность токена")
	    exit(1)
	# Получаем инфу о последнем коммите в ветке workBranch
	commitHead = requests.get('{0}/{1}/git/commits/{2}'.format(self.prefix, repo, shaHead),
				    auth=(self.user, self.token), 
				    headers=self.header)
	# Получаем хэш дерева
	shaTree = commitHead.json()['tree']['sha'] 

	# Собираем названия файлов, кроме .git
	filesList = self.__getProjectFiles()

	fileShaBlobDict = dict()
	# Загрузка содержимого файлов
	for file in filesList:

	    changedFilesData = {"content":  open(file,"r").read()}  
	    blob = requests.post('{0}/{1}/git/blobs'.format(self.prefix, repo),
				  json=changedFilesData,
				  auth=(self.user, self.token),
				  headers=self.header)

	    fileShaBlobDict[file] = blob.json()['sha']
	# Создание информации о файлах
	changedFilesData = {"tree" : []}
	for file, shaBlob in fileShaBlobDict.items():
	    changedFilesData["tree"].append({"path":file,
					     "mode":"100644",
					     "type":"blob",
					     "sha": shaBlob})

	# инфа дерева последнего коммита
	tree = requests.get('{0}/{1}/git/trees/{2}'.format(self.prefix, repo, shaTree), 
			     auth=(self.user, self.token),
			     headers=self.header)

	# создаем дерево
	treeHead = requests.post('{0}/{1}/git/trees'.format(self.prefix, repo),
				  json=changedFilesData, auth=(self.user, self.token), 
				  headers=self.header)

	shaTreeHead = treeHead.json()['sha']
	#Создание коммита
	commitInfo = {"message":message,"tree": shaTreeHead, "parents": [shaHead] }
	commitRespons = requests.post('{0}/{1}/git/commits'.format(self.prefix, repo),
				       json=commitInfo, 
				       auth=(self.user, self.token),
				       headers=self.header)

	shaNewCommit = commitRespons.json()['sha']

	updateInfo = {"sha": shaNewCommit}
	updateResponse = requests.post('{0}/{1}/git/refs/heads/{2}'.format(self.prefix, repo, workBranch),
					json=updateInfo,
					auth=(self.user, self.token),
					headers=self.header)

    def pullRequest(self, workBranch, repo, message):

	pullRequestInfo = {"head": workBranch,"base":"master", "title" : message}
	pullRequestRespons = requests.post('{0}/{1}/pulls'.format(self.prefix, repo),
					    json=pullRequestInfo,
					    auth=(self.user, self.token),
					    headers=self.header)

    def __getProjectFiles(self):
	folder = []
	for i in os.walk('.'):
	    # Убираем директорию .git
	    if('.git' not in i[0]):
		folder.append(i)
	filesList = [] 
	for address, dirs, files in folder:
	    for file in files:
		path = address+'/'+file
		filesList.append(path.split('./')[1])

	return filesList



url = "https://api.github.com"
user = "myLogin"
token = "myToken"
repo = "myRepo"
workBranch = "myBranch"
try: 
    message = sys.argv[1]
except IndexError:
    print("Необходимо ввести текст коммита!")
    exit(1)

test = GithubApi(url, user, token)
test.commitPush(workBranch, repo, message)
test.pullRequest(workBranch, repo, message)
```

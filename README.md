# devops-netology


    1. 
    	{
			"info": "Sample JSON output from our service\t",
			"elements": [{
					"name": "first",
					"type": "server",
					"ip": 7175
				},
				{
					"name": "second",
					"type": "proxy",
					"ip": "71.78.22.43"
				}
			]
		}

    2. 	
    	#!/usr/bin/env python3

		import json
		import socket
		import time
		import yaml

		urlList = ["drive.google.com", "mail.google.com", "google.com"]
		lastIpList = [socket.gethostbyname(url) for url in urlList]

		while(1>0):
		    for i in range(len(urlList)):

		        data = dict()
		        currentIp = socket.gethostbyname(urlList[i])

		        if lastIpList[i] != currentIp:
		            print ("[ERROR] {0} IP mismatch: {1} {2}".format(urlList[i], lastIpList[i], currentIp))
		        else:
		            print ("{0} - {1}".format(urlList[i],socket.gethostbyname(urlList[i])))

		        lastIpList[i] = currentIp

		        data[urlList[i]] = currentIp
		        with open(urlList[i] + '.json', 'w') as outfile:
		            json.dump(data, outfile)

		        with open(urlList[i] +  '.yaml', 'w') as outfile:
		            yaml.dump(data, outfile)
		    
		    print('\n')
		    time.sleep(1)

    
    3. 
		#!/usr/bin/env python3

		import json
		import sys
		import yaml

		def checkFileName(filePath):

		    if not ((filePath[-5:] == ".yaml") or (filePath[-5:] == ".json") or (filePath[-4:] == ".yml")):
		        print("the file format is neither json nor yaml/yml")
		        exit(1)

		def checkJson (filePath):

		     with open(filePath, 'r') as file:
		            return file.read(1) == '{'

		def checkYaml (filePath):

		     with open(filePath, 'r') as file:
		            return "---" in file.readline()

		def jsonToYaml(filePath):
		    
		    with open(filePath) as jsonFile:
		        try:
		            data = json.load(jsonFile)
		        except json.decoder.JSONDecodeError as e:
		            print(e)
		            exit(1)

		    with open(filePath.split(".")[0] + ".yaml", 'w') as yamlFile:
		            yaml.dump(data, yamlFile, explicit_start=True)

		def yamlToJson(filePath):
		    
		    with open(filePath) as yamlFile:
		        try:
		            data = yaml.load(yamlFile,  Loader=yaml.FullLoader)
		        except yaml.scanner.ScannerError as e:
		            print(e)
		            exit(1)

		    with open(filePath.split(".")[0] + ".json", 'w') as jsonFile:
		            json.dump(data, jsonFile, indent=3)


		if __name__ == "__main__":
		     
		    try:
		        filePath = sys.argv[1]
		    except Exception:
		        print("enter file name")

		    checkFileName(filePath)

		    isJson = checkJson(filePath)
		    isYaml = checkYaml(filePath)

		    if (isJson):
		        jsonToYaml(filePath)
		    elif(isYaml):
		        yamlToJson(filePath)
		    else:
		        print("the file should contain '---' for yaml or '{' for json in the first line")
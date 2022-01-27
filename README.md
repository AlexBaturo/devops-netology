1. 	**kibana-role**:   Роль скачивает с сайта artifacts.elastic.co пакет kibana. В зависимости от типа ОС deb или centos загружается deb или rpm пакет соответсвенно. Далее производится установка и конфигурация установленного пакета.    		     
	
	**vars**:
		elasticsearch_version
			
2. 	**filebeat-role**: Роль скачивает с сайта artifacts.elastic.co пакет filebeat. В зависимости от типа ОС deb или centos загружается deb или rpm пакет соответсвенно. Далее производится установка и конфигурация установленного пакета.  
	
	**vars**:
		elasticsearch_version

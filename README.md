	6. Попробуйте запустить playbook на этом окружении с флагом --check.

		alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod/hosts.yml  site.yml --check

		PLAY [Install Elasticsearch] ************************************************************************************************

		TASK [Gathering Facts] ******************************************************************************************************
		ok: [el-instance]

		TASK [Download Elasticsearch's rpm] *****************************************************************************************
		changed: [el-instance]

		TASK [Install Elasticsearch] ************************************************************************************************
		fatal: [el-instance]: FAILED! => {"changed": false, "msg": "No RPM file matching '/tmp/elasticsearch-7.14.0-x86_64.rpm' found on system", "rc": 127, "results": ["No RPM file matching '/tmp/elasticsearch-7.14.0-x86_64.rpm' found on system"]}

		PLAY RECAP ******************************************************************************************************************
		el-instance                : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

	7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.

		Часть лога ansible, на который видны произведенные изменения.

		RUNNING HANDLER [restart Elasticsearch] *************************************************************************************
		changed: [el-instance]

		PLAY [Install Kibana] *******************************************************************************************************

		TASK [Gathering Facts] ******************************************************************************************************
		ok: [k-instance]

		TASK [Download Kibana's rpm] ************************************************************************************************
		changed: [k-instance]

		TASK [Install Kibana] *******************************************************************************************************
		changed: [k-instance]

		TASK [Configure Kibana] *****************************************************************************************************
		--- before: /etc/kibana/kibana.yml
		+++ after: /home/alex/.ansible/tmp/ansible-local-203670br3gzyt/tmpudguvmww/kibana.yml.j2
		@@ -1,111 +1,3 @@
		-# Kibana is served by a back end server. This setting specifies the port to use.
		-#server.port: 5601
		-
		-# Specifies the address to which the Kibana server will bind. IP addresses and host names are both valid values.
		-# The default is 'localhost', which usually means remote machines will not be able to connect.
		-# To allow connections from remote users, set this parameter to a non-loopback address.
		-#server.host: "localhost"

	8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.

		та же часть лога ansible, что и в пункте 7 при повторном запуске ansible с флагом --diff

		PLAY [Install Filebeat] *****************************************************************************************************

		TASK [Gathering Facts] ******************************************************************************************************
		ok: [f-instance]

		TASK [Download Filebeat's rpm] **********************************************************************************************
		ok: [f-instance]

		TASK [Install Filebeat] *****************************************************************************************************
		ok: [f-instance]

		TASK [Configure Filebeat] ***************************************************************************************************
		ok: [f-instance]

		TASK [Enable module] ********************************************************************************************************
		ok: [f-instance]


	9. playbook устанавливает elasticsearch, kibana, filebeat на хосты el-instance, k-instance, f-instance соответсвенно и производит настройку установленнго ПО. 

		Для хостов устанавливаются следующие параметры и тэги:

		all:
			vars:
				- elk_stack_version

		el-instance:
			tags:
				- elastic
		
		k-instance:
			tags:
				- kibana

		logstash_host:
			tags:
				- filebeat

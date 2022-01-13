	6. Попробуйте запустить playbook на этом окружении с флагом --check.

		alex@alex-N46JV:~/Desktop/Projects/devops-netology/playbook$ ansible-playbook -i inventory/prod.yml site.yml --check

		PLAY [Install Java] *****************************************************************************************************************

		TASK [Gathering Facts] **************************************************************************************************************
		ok: [elastic]
		ok: [kibana]
		ok: [logstash]

		TASK [Set facts for Java 11 vars] ***************************************************************************************************
		ok: [kibana]
		ok: [elastic]
		ok: [logstash]

		TASK [Upload .tar.gz file containing binaries from local storage] *******************************************************************
		changed: [elastic]
		changed: [logstash]
		changed: [kibana]

		TASK [Ensure installation dir exists] ***********************************************************************************************
		changed: [logstash]
		changed: [elastic]
		changed: [kibana]

		TASK [Extract java in the installation directory] ***********************************************************************************
		fatal: [logstash]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}
		fatal: [elastic]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}
		fatal: [kibana]: FAILED! => {"changed": false, "msg": "dest '/opt/jdk/11.0.11' must be an existing dir"}

		PLAY RECAP **************************************************************************************************************************
		elastic                    : ok=5    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
		kibana                     : ok=5    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   
		logstash                   : ok=5    changed=2    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0

		С флагом --check не создались директории /opt/jdk/11.0.11

	7. Запустите playbook на prod.yml окружении с флагом --diff. Убедитесь, что изменения на системе произведены.

		Часть лога ansible, на который видны произведенные изменения.

		TASK [Export environment variables] *************************************************************************************************
		--- before
		+++ after: /home/alex/.ansible/tmp/ansible-local-695190vsacai8b/tmpaa7wra_l/jdk.sh.j2
		@@ -0,0 +1,5 @@
		+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
		+#!/usr/bin/env bash
		+
		+export JAVA_HOME=/opt/jdk/11.0.11
		+export PATH=$PATH:$JAVA_HOME/bin
		\ No newline at end of file

		changed: [logstash]
		--- before
		+++ after: /home/alex/.ansible/tmp/ansible-local-695190vsacai8b/tmp9ir_ddmn/jdk.sh.j2
		@@ -0,0 +1,5 @@
		+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
		+#!/usr/bin/env bash
		+
		+export JAVA_HOME=/opt/jdk/11.0.11
		+export PATH=$PATH:$JAVA_HOME/bin
		\ No newline at end of file

		changed: [elastic]
		--- before
		+++ after: /home/alex/.ansible/tmp/ansible-local-695190vsacai8b/tmpumd7mkio/jdk.sh.j2
		@@ -0,0 +1,5 @@
		+# Warning: This file is Ansible Managed, manual changes will be overwritten on next playbook run.
		+#!/usr/bin/env bash
		+
		+export JAVA_HOME=/opt/jdk/11.0.11
		+export PATH=$PATH:$JAVA_HOME/bin
		\ No newline at end of file

		changed: [kibana]

	8. Повторно запустите playbook с флагом --diff и убедитесь, что playbook идемпотентен.

		та же часть лога ansible, что и в пункте 7 при повторном запуске ansible с флагом --diff

		TASK [Export environment variables] *************************************************************************************************
		ok: [logstash]
		ok: [kibana]
		ok: [elastic]

	9. playbook устанавливает elasticsearch, kibana, logstash на хосты elasticsearch, kibana_host, logstash_host соответсвенно и производит настройку установленнго ПО. 

		Для хостов устанавливаются следующие параметры и тэги:

		all:
			vars:
				- java_jdk_version
				- java_oracle_jdk_package
			tags:
				- java

		elasticsearch:
			vars: 
				- elastic_version
				- elastic_home
				- elastic_port
			tags:
				- elastic
		
		kibana_host:
			vars:
				- kibana_version
				- kibana_home
			tags:
				- kibana

		logstash_host:
			vars:
				- logstash_version
				- logstash_home
			tags:
				- logstash






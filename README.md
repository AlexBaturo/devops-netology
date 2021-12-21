    1. 
        ansible-playbook -i inventory/test.yml  site.yml

        TASK [Print OS] ****************************************************************************************************************
        ok: [localhost] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] **************************************************************************************************************
        ok: [localhost] => {
            "msg": 12
        }

    2. Изменил в group_vars/all/examp.yml "12" на "all default fact"

    3.  Запустил для контейнера для создания окружения:
            docker run -dt --name ubuntu ubuntu
            docker run -dt --name centos7 centos:7

            в контейнер ubuntu установил python3 

    4.  
        alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod.yml  site.yml
        PLAY [Print os facts] ********************************************************************************************************

        TASK [Gathering Facts] *******************************************************************************************************
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] **************************************************************************************************************
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************************************************************************************
        ok: [centos7] => {
            "msg": "el"
        }
        ok: [ubuntu] => {
            "msg": "deb"
        }

        PLAY RECAP *******************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

    5.  Изменил в group_vars/deb/examp.yml "deb" на "deb default fact"
        Изменил в group_vars/el/examp.yml "el" на "el default fact"

    6.  
        alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod.yml  site.yml
        PLAY [Print os facts] ********************************************************************************************************

        TASK [Gathering Facts] *******************************************************************************************************
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] **************************************************************************************************************
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************************************************************************************
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

        PLAY RECAP *******************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

    7.
        ansible-vault encrypt group_vars/el/examp.yml
        ansible-vault encrypt group_vars/deb/examp.yml

    8.
        alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod.yml  site.yml --ask-vault-pass
        Vault password: 

        PLAY [Print os facts] ********************************************************************************************************

        TASK [Gathering Facts] *******************************************************************************************************
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] **************************************************************************************************************
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************************************************************************************
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

        PLAY RECAP *******************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

    9. 
        Для работы с control node выбрал плагин local

    10. 
        в inventory/prod.yml дописано следующее:
            local:
                hosts:
                  localhost:
                    ansible_connection: local
    11. 
        alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod.yml  site.yml --ask-vault-pass
        Vault password: 

        PLAY [Print os facts] ********************************************************************************************************

        TASK [Gathering Facts] *******************************************************************************************************
        ok: [localhost]
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] **************************************************************************************************************
        ok: [localhost] => {
            "msg": "Ubuntu"
        }
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************************************************************************************
        ok: [localhost] => {
            "msg": "all default fact"
        }
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

        PLAY RECAP *******************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

    Необязательная часть

    1. 
        ansible-vault decrypt group_vars/el/examp.yml
        ansible-vault decrypt group_vars/deb/examp.yml

    2.  
        ansible-vault encrypt_string 'PaSSw0rd' --name 'some_fact'

        some_fact: !vault |
          $ANSIBLE_VAULT;1.1;AES256
          30383861623230613832306339656162326133396266366634663065616266346634343163343332
          3563313937356463616639623166353339616363646263370a303238613038363633386137656636
          31666533643730323964396237303230323662343738336130393663373230333637386364333831
          3466346131313436620a306431376230363435313466633461313030656633396339333261343237
          6431

        полученное значение записал в файл group_vars/all/examp.yml вместо "all default fact"

    3.  
        alex@alex-N46JV:~/Desktop/Projects/devops-netology$ ansible-playbook -i inventory/prod.yml  site.yml --ask-vault-pass
        Vault password: 

        PLAY [Print os facts] ********************************************************************************************************

        TASK [Gathering Facts] *******************************************************************************************************
        ok: [localhost]
        ok: [ubuntu]
        ok: [centos7]

        TASK [Print OS] **************************************************************************************************************
        ok: [localhost] => {
            "msg": "Ubuntu"
        }
        ok: [centos7] => {
            "msg": "CentOS"
        }
        ok: [ubuntu] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] ************************************************************************************************************
        ok: [localhost] => {
            "msg": "PaSSw0rd"
        }
        ok: [centos7] => {
            "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

        PLAY RECAP *******************************************************************************************************************
        centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
        ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

    4. 
        в inventory/prod.yml добавлена часть:
              fc:
                hosts:
                  fedora:
                    ansible_connection: docker
        Создан файл group_vars/fc/examp.yml
            ---
            some_fact: "fc default fact"

    5.
        Создан скрипт

        docker run -dt --name fedora pycontribs/fedora 2> /dev/null || docker start fedora
        docker run -dt --name ubuntu ubuntu 2> /dev/null || docker start ubuntu
        docker run -dt --name centos7 centos:7 2> /dev/null || docker start centos7
        ansible-playbook -i inventory/prod.yml  site.yml --vault-password-file ~/.vault_pass.txt
        docker stop fedora centos7 ubuntu
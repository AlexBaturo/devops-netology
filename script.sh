docker run -dt --name fedora pycontribs/fedora 2> /dev/null || docker start fedora
docker run -dt --name ubuntu ubuntu 2> /dev/null || docker start ubuntu
docker run -dt --name centos7 centos:7 2> /dev/null || docker start centos7

ansible-playbook -i inventory/prod.yml  site.yml --vault-password-file ~/.vault_pass.txt
docker stop fedora centos7 ubuntu
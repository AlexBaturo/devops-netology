# devops-netology


    1. 
	Dockerfile:
		FROM centos

		RUN curl -o /opt/ponysay-3.0.3-1.noarch.rpm https://raw.githubusercontent.com/rpmsphere/noarch/master/p/ponysay-3.0.3-1.noarch.rpm \
		    && rpm -i /opt/ponysay-3.0.3-1.noarch.rpm \
		    && yum install python3 -y \
		    && ln -s python3 /usr/bin/python

		ENTRYPOINT ["/usr/bin/ponysay"]
		CMD ["Hey, netology”]

	Ссылка на dockerhub:
		https://hub.docker.com/r/alexbatrrr/pony/tags

	Скриншот в закрепленных файлах:
		pony - вывод команды
    2.	
    amazoncorreto Dockerfile:
		FROM amazoncorretto

		RUN curl -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo \
		    && rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key \
		    && amazon-linux-extras install epel -y \
		    && yum install java-11-openjdk-devel -y \
		    && yum install jenkins -y

		EXPOSE 8080

		CMD java -jar --add-opens java.base/java.lang=ALL-UNNAMED /usr/lib/jenkins/jenkins.war --enable-future-java --httpPort=8080

	ubuntu Dockerfile:
		FROM ubuntu:latest

		RUN apt-get update \
		    && apt install wget gnupg tzdata -y \
		    && ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure -f noninteractive tzdata \
		    && wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add - \
		    && sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' \
		    && apt-get update \
		    && apt-get install openjdk-11-jdk jenkins -y 

		EXPOSE 9090

		CMD java -jar --add-opens java.base/java.lang=ALL-UNNAMED /usr/share/jenkins/jenkins.war --enable-future-java --httpPort=9090

	ссылка на dockerhub:
		https://hub.docker.com/r/alexbatrrr/jenkins/tags

	Скриншоты в закрепленных файлах:
		JenkinsInterface1 - веб-интерфейс amazoncorretto
		JenkinsInterface2 - веб-интерфейс ubuntu
		Console1 - скриншот amazoncorretto
		Console2 - скриншот ubuntu
    3. 	
    Dockerfile:
		FROM node

		RUN git clone https://github.com/simplicitesoftware/nodejs-demo.git /opt/nodejs-demo \
		    && npm install --prefix /opt/nodejs-demo/ \
		    && npm audit fix --prefix /opt/nodejs-demo/

		EXPOSE 3000

		CMD npm start --prefix /opt/nodejs-demo/ --host 0.0.0.0 --port 3000

    Скриншоты в закрепленных файлах:
		curl - вызов curl 
		inspect - вместо docker network cli
		networkLs - вместо docker network cli

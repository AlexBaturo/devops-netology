# devops-netology

    1.  Используя знания из лекции по systemd, создайте самостоятельно простой unit-файл для node_exporte
        /etc/systemd/system/node_exporter.service
        [Unit]
        Description=node_exporter
        
        [Service]
        EnvironmentFile=/etc/default/node_exporter
        ExecStart=/opt/node_exporter $EXTRA_OPTS
        
        [Install]
        WantedBy=multi-user.target

        Добавление в автозагрузку
        systemctl enable node_exporter

    2. Приведите несколько опций, которые вы бы выбрали для базового мониторинга хоста по CPU, памяти, диску и сети.
        --collector.cpu 
        --collector.cpu.info

        --collector.meminfo

        --collector.diskstats
        --collector.filesystem 

        --collector.network_route
    
    3. Заменил строку bind socket to IP = 127.0.0.1 на bind to = 0.0.0.0 в секции [global] тк секция [web] отсутствует

    4.  Можно ли по выводу dmesg понять, осознает ли ОС, что загружена не на настоящем оборудовании, а на системе виртуализации?
        при вызове dmesg появились следующие строки
        [   25.252728] 17:54:57.181784 main     VBoxService 6.1.16 r140961 (verbosity: 0) linux.amd64 (Oct 15 2020 16:40:53) release log
               17:54:57.181794 main     Log opened 2021-06-09T17:54:57.181762000Z
        [   25.252880] 17:54:57.182038 main     OS Product: Linux
        [   25.252982] 17:54:57.182166 main     OS Release: 5.4.0-58-generic
        [   25.253053] 17:54:57.182239 main     OS Version: #64-Ubuntu SMP Wed Dec 9 08:16:25 UTC 2020
        [   25.253164] 17:54:57.182327 main     Executable: /opt/VBoxGuestAdditions-6.1.16/sbin/VBoxService
               17:54:57.182329 main     Process ID: 778
    
    5. Как настроен sysctl fs.nr_open на системе по-умолчанию? Узнайте, что означает этот параметр.
        По умолчанию fs.nr_open = 1048576
        Означает максимальное количество файловых дескрипторов, которое может создать процесс.
       Какой другой существующий лимит не позволит достичь такого числа (ulimit --help)?
         ulimit -n
          1024

    6. Запустите любой долгоживущий процесс (не ls, который отработает мгновенно, а, например, sleep 1h) в отдельном неймспейсе процессов; 
        покажите, что ваш процесс работает под PID 1 через nsenter.
        unshare -f --pid --mount-proc sleep 1h &
        root        3663  0.0  0.0   8076   528 pts/4    S    18:09   0:00 sleep 1h
        
        nsenter --target 3663 --pid --mount
        USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
        root           1  0.0  0.0   8076   528 pts/4    S+   18:09   0:00 sleep 1h
        root           2  0.0  0.4   9968  4220 pts/1    S    18:09   0:00 -bash
        root          11  0.0  0.3  11492  3420 pts/1    R+   18:09   0:00 ps aux

    7. Найдите информацию о том, что такое :(){ :|:& };:
        В данной конструкции ':' является название функции :() - функция, в теле функции она вызывает сама себя,
        что порождает создание новых процессов. Так будет происходить, пока количество процессов не достигнет установленного максимума
        Сообщение из dmesg:
            cgroup: fork rejected by pids controller in /user.slice/user-1000.slice/session-8.scope
        По умолчанию ulimit -u   3579
        ulimit -u <number>

    

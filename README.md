# devops-netology

    1. Какого типа команда cd? Попробуйте объяснить, почему она именно такого типа; опишите ход своих мыслей, если считаете что она могла бы быть другого типа.
            cd - команда встроенная в командную оболочку (builtin). Данная команда обеспечивает одну из основных возможностей 
                оболочки - перемещение по директориям. В целом не что не мешает сделать cd типом file и устанавливать отдельно от того же bash, 
                но bash потеряет базовый функционал и сам по себе будет бесполезен.

    2. Какая альтернатива без pipe команде grep <some_string> <some_file> | wc -l?
            grep -c <some_string> <some_file> 
       
    3. Какой процесс с PID 1 является родителем для всех процессов в вашей виртуальной машине Ubuntu 20.04?
            vagrant@vagrant:~$ ps aux
            USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
            root           1  2.0  1.1 167540 11424 ?        Ss   14:04   0:01 /sbin/init
            root           2  0.0  0.0      0     0 ?        S    14:04   0:00 [kthreadd]
            root           3  0.0  0.0      0     0 ?        I<   14:04   0:00 [rcu_gp]

             
    4. Как будет выглядеть команда, которая перенаправит вывод stderr ls на другую сессию терминала?
            если наша сессия /dev/pts/x
            другая - /dev/pts/y
            ls <some_file> 2> /dev/pts/y

    5. Получится ли одновременно передать команде файл на stdin и вывести ее stdout в другой файл? Приведите работающий пример.
            grep <some_string> < <input_file> > <output_file>

    6. Получится ли вывести находясь в графическом режиме данные из PTY в какой-либо из эмуляторов TTY? Сможете ли вы наблюдать выводимые данные?
            например, так ls <some_file> > /dev/tty3 далее необходимо переключиться на tty3 командой ctrl+alt+F3 

    7. Выполните команду bash 5>&1. К чему она приведет? Что будет, если вы выполните echo netology > /proc/$$/fd/5? Почему так происходит?
            bash 5>&1  bash создает файловый дескриптор под номером 5 и связывает его с потоком вывода
            echo netology > /proc/$$/fd/5  записывает слово netology в дескриптор 5 и запись попадает в стандартный поток вывода
        
    8. Получится ли в качестве входного потока для pipe использовать только stderr команды, не потеряв при этом отображение stdout на pty? 
       Напоминаем: по умолчанию через pipe передается только stdout команды слева от | на stdin команды справа. Это можно сделать, 
       поменяв стандартные потоки местами через промежуточный новый дескриптор, который вы научились создавать в предыдущем вопросе.
            ls old 3>&1 1>&2 2>&3 | sed 's/old/new/'
            ls: cannot access 'new': No such file or directory  в выводе stderr название файла old изменилось на new

    9. Что выведет команда cat /proc/$$/environ? Как еще можно получить аналогичный по содержанию вывод?
            /proc/$$/environ выводит содержимое файла, который содержит переменные, доступные для процесса, которые были установлены при запуске данного процесса
            ps heo args $$ 

    10. Используя man, опишите что доступно по адресам /proc/<PID>/cmdline, /proc/<PID>/exe
            /proc/<PID>/cmdline файл содержит полную командную строку, которой был запущен данный процес. У зомби процесса файл вернет 0
            /proc/<PID>/exe файл содержит символическую ссылку с полным путем к выполняемой команде  

    11. Узнайте, какую наиболее старшую версию набора инструкций SSE поддерживает ваш процессор с помощью /proc/cpuinfo.
            sse4_2

    12. При открытии нового окна терминала и vagrant ssh создается новая сессия и выделяется pty.
        Почитайте, почему так происходит, и как изменить поведение.
            При выполнении удаленной команды через ssh pty сессия не выделяется, однако можно изменить поведение, используя ключ -t  
            ssh -t localhost 'tty'

    13. Бывает, что есть необходимость переместить запущенный процесс из одной сессии в другую.
        Попробуйте сделать это, воспользовавшись reptyr. Например, так можно перенести в screen процесс, который вы запустили по ошибке в обычной SSH-сессии.
            1) создал скрипт с выводом hello в бесконечном цикле, чтобы процесс не завершался
            2) screen
            3) reptyr <pid> 
            Вывод скрипта появился в новой сесси

    14.  Узнайте что делает команда tee и почему в отличие от sudo echo команда с sudo tee будет работать.
            Команда tee считывает входной поток и выдает эту же строку в выходной поток. В отличие от echo tee является
            самостоятельной программой типа file (echo - builtin) это позволяет через sudo запустить ее с правами 
            суперпользователя.
        
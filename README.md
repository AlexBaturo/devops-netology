# devops-netology


    1. Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.
    	1) тк виртуалки должны быть и на Linux и на windows, Hyper V не подойдет. Тк нужно больше количество ВМ, но нет особых требований к ним можно воспользоваться open source решениями. Подойдет Xen, тк у него реализованы балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий

    	2) В данном случае, лучше всего подойдет Xen тк он поддерживает паравиртуализацию в отличие от KVM, поддерживающий только аппаратную виртуализацию

    	3) Для Windows инфраструктуры лучше всего подойдет Hyper-V Server 2019. Этот вариант бесплатный и наиболее совместим с Windows.

    	4) Для создания небольшого количества ВМ подойдет Virtual Box

    2. Опишите сценарий миграции с VMware vSphere на Hyper-V для Linux и Windows виртуальных машин. Детально опишите необходимые 	шаги для использования всех преимуществ Hyper-V для Windows.

    	При экспорте можно воспользоваться "Мастером преобразования виртуальных машин" в System Center VMM

    	Необходимо учитывать ряд ограничений
    	1) См. подробнее о требованиях к системе для поддерживаемых версий vSphere (ESXi).
		2) Нельзя преобразовывать рабочие станции VMware.
		3) Нельзя преобразовывать виртуальные машины с виртуальными жесткими дисками, подключенными к шине IDE.
		4) Оперативное преобразование не поддерживается. Необходимо выключать виртуальные машины VMware.
		5) Должны поддерживаться антивирусные программы.
		6) Средства VMware необходимо удалить из операционной системы виртуальной машины.

		Далее выполнить по шагам инструкцию  "Преобразование с помощью мастера" https://docs.microsoft.com/ru-ru/system-center/vmm/vm-convert-vmware?view=sc-vmm-2019

	 3. Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был бы выбор, то создавали ли вы бы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.

	  	 Несколько систем управления виртуализацией одновременно невозможно поставить на железо, поэтому необходима установка
	  	  операционной системы, что делает такой вариант менее производительным.
	  	  Такой вариант сложнее в управлении и поддержке тк появляются несколько менеджеров виртуализации.
	  	  Так же не уверен, что ресурсы, к которым обращаются гипервизоры изолированы и гипервизор А будет использовать ресурсы гипервизора Б. Для минимизации такой проблемы лучше использовать физически разные ресурсы.
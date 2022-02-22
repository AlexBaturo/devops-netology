import datetime
import json

data = {}
with open('/proc/meminfo', 'r') as fp:
	mem_total = fp.readline()
	data[mem_total.split(':')[0]] = mem_total.split(':')[1]

	mem_free = fp.readline()
	data[mem_free.split(':')[0]] = mem_free.split(':')[1]

with open('/proc/stat', 'r') as fp:
	for _ in range(7):
		cpu = fp.readline()
	key = cpu.split(' ')[0]
	data[cpu.split(' ')[0]] = cpu.split(key)[1]

with open('/proc/loadavg', 'r') as fp:
	load = fp.readline()
	data["loadavg"] = load

for key, value in  data.items():
	data[key] = value.rstrip().replace("  ", "")

date = datetime.datetime.now().strftime('%Y-%m-%d')
with open('/var/log/{}-awesome-monitoring.json'.format(date), 'a') as log_file:
	output_dict = {"timestamp": datetime.datetime.now().strftime('%H:%M:%S')}
	output_dict.update(data)
	json.dump(output_dict, log_file)
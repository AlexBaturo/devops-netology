	1. Скриншот task1.jpg

	2.
		Утилизация CPU для nodeexporter (в процентах, 100-idle)
			100 - (avg by (instance) (rate(node_cpu_seconds_total{cpu="0", instance="nodeexporter:9100", job="nodeexporter", mode="idle"}[1m]))*100 )

		CPULA 1/5/15
			node_load1{instance="nodeexporter:9100", job="nodeexporter"}
			node_load5{instance="nodeexporter:9100", job="nodeexporter"}
			node_load15{instance="nodeexporter:9100", job="nodeexporter"}

		Количество свободной оперативной памяти
			node_memory_MemFree_bytes{instance="nodeexporter:9100", job="nodeexporter"}

		Количество места на файловой системе
			node_filesystem_free_bytes{device="/dev/sda8", fstype="ext4", instance="nodeexporter:9100", job="nodeexporter", mountpoint="/"}

		Скриншот task2.jpg

	3. 	Скриншот task3.jpg

	4.

		{
		  "annotations": {
		    "list": [
		      {
		        "builtIn": 1,
		        "datasource": "-- Grafana --",
		        "enable": true,
		        "hide": true,
		        "iconColor": "rgba(0, 211, 255, 1)",
		        "name": "Annotations & Alerts",
		        "type": "dashboard"
		      }
		    ]
		  },
		  "editable": true,
		  "gnetId": null,
		  "graphTooltip": 0,
		  "id": 1,
		  "links": [],
		  "panels": [
		    {
		      "alert": {
		        "alertRuleTags": {},
		        "conditions": [
		          {
		            "evaluator": {
		              "params": [
		                25
		              ],
		              "type": "gt"
		            },
		            "operator": {
		              "type": "and"
		            },
		            "query": {
		              "params": [
		                "A",
		                "5m",
		                "now"
		              ]
		            },
		            "reducer": {
		              "params": [],
		              "type": "avg"
		            },
		            "type": "query"
		          }
		        ],
		        "executionErrorState": "alerting",
		        "for": "5m",
		        "frequency": "1m",
		        "handler": 1,
		        "name": "CPU_0 utiliztion alert",
		        "noDataState": "no_data",
		        "notifications": []
		      },
		      "aliasColors": {},
		      "bars": false,
		      "dashLength": 10,
		      "dashes": false,
		      "datasource": null,
		      "fieldConfig": {
		        "defaults": {
		          "custom": {}
		        },
		        "overrides": []
		      },
		      "fill": 1,
		      "fillGradient": 0,
		      "gridPos": {
		        "h": 8,
		        "w": 12,
		        "x": 0,
		        "y": 0
		      },
		      "hiddenSeries": false,
		      "id": 10,
		      "legend": {
		        "avg": false,
		        "current": false,
		        "max": false,
		        "min": false,
		        "show": true,
		        "total": false,
		        "values": false
		      },
		      "lines": true,
		      "linewidth": 1,
		      "nullPointMode": "null",
		      "options": {
		        "alertThreshold": true
		      },
		      "percentage": false,
		      "pluginVersion": "7.4.0",
		      "pointradius": 2,
		      "points": false,
		      "renderer": "flot",
		      "seriesOverrides": [],
		      "spaceLength": 10,
		      "stack": false,
		      "steppedLine": false,
		      "targets": [
		        {
		          "expr": "100 - (avg by (instance) \n(rate(node_cpu_seconds_total{cpu=\"0\", instance=\"nodeexporter:9100\", job=\"nodeexporter\", mode=\"idle\"}[1m]))*100 )",
		          "interval": "",
		          "legendFormat": "",
		          "refId": "A"
		        }
		      ],
		      "thresholds": [
		        {
		          "colorMode": "critical",
		          "fill": true,
		          "line": true,
		          "op": "gt",
		          "value": 25,
		          "visible": true
		        }
		      ],
		      "timeFrom": null,
		      "timeRegions": [],
		      "timeShift": null,
		      "title": "CPU_0 utiliztion",
		      "tooltip": {
		        "shared": true,
		        "sort": 0,
		        "value_type": "individual"
		      },
		      "type": "graph",
		      "xaxis": {
		        "buckets": null,
		        "mode": "time",
		        "name": null,
		        "show": true,
		        "values": []
		      },
		      "yaxes": [
		        {
		          "$$hashKey": "object:401",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        },
		        {
		          "$$hashKey": "object:402",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        }
		      ],
		      "yaxis": {
		        "align": false,
		        "alignLevel": null
		      }
		    },
		    {
		      "alert": {
		        "alertRuleTags": {},
		        "conditions": [
		          {
		            "evaluator": {
		              "params": [
		                2017587940
		              ],
		              "type": "lt"
		            },
		            "operator": {
		              "type": "and"
		            },
		            "query": {
		              "params": [
		                "A",
		                "5m",
		                "now"
		              ]
		            },
		            "reducer": {
		              "params": [],
		              "type": "avg"
		            },
		            "type": "query"
		          }
		        ],
		        "executionErrorState": "alerting",
		        "for": "5m",
		        "frequency": "1m",
		        "handler": 1,
		        "name": "RAM free alert",
		        "noDataState": "no_data",
		        "notifications": []
		      },
		      "aliasColors": {},
		      "bars": false,
		      "dashLength": 10,
		      "dashes": false,
		      "datasource": null,
		      "description": "",
		      "fieldConfig": {
		        "defaults": {
		          "color": {},
		          "custom": {},
		          "thresholds": {
		            "mode": "absolute",
		            "steps": []
		          },
		          "unit": "bytes"
		        },
		        "overrides": []
		      },
		      "fill": 1,
		      "fillGradient": 0,
		      "gridPos": {
		        "h": 8,
		        "w": 12,
		        "x": 12,
		        "y": 0
		      },
		      "hiddenSeries": false,
		      "id": 4,
		      "legend": {
		        "avg": false,
		        "current": false,
		        "max": false,
		        "min": false,
		        "show": true,
		        "total": false,
		        "values": false
		      },
		      "lines": true,
		      "linewidth": 1,
		      "nullPointMode": "null",
		      "options": {
		        "alertThreshold": true
		      },
		      "percentage": false,
		      "pluginVersion": "7.4.0",
		      "pointradius": 2,
		      "points": false,
		      "renderer": "flot",
		      "seriesOverrides": [],
		      "spaceLength": 10,
		      "stack": false,
		      "steppedLine": false,
		      "targets": [
		        {
		          "expr": "node_memory_MemFree_bytes{instance=\"nodeexporter:9100\", job=\"nodeexporter\"}",
		          "interval": "",
		          "legendFormat": "",
		          "refId": "A"
		        }
		      ],
		      "thresholds": [
		        {
		          "colorMode": "critical",
		          "fill": true,
		          "line": true,
		          "op": "lt",
		          "value": 2017587940,
		          "visible": true
		        }
		      ],
		      "timeFrom": null,
		      "timeRegions": [],
		      "timeShift": null,
		      "title": "RAM free",
		      "tooltip": {
		        "shared": true,
		        "sort": 0,
		        "value_type": "individual"
		      },
		      "type": "graph",
		      "xaxis": {
		        "buckets": null,
		        "mode": "time",
		        "name": null,
		        "show": true,
		        "values": []
		      },
		      "yaxes": [
		        {
		          "$$hashKey": "object:777",
		          "format": "bytes",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        },
		        {
		          "$$hashKey": "object:778",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        }
		      ],
		      "yaxis": {
		        "align": false,
		        "alignLevel": null
		      }
		    },
		    {
		      "alert": {
		        "alertRuleTags": {},
		        "conditions": [
		          {
		            "evaluator": {
		              "params": [
		                2.5
		              ],
		              "type": "gt"
		            },
		            "operator": {
		              "type": "and"
		            },
		            "query": {
		              "params": [
		                "A",
		                "5m",
		                "now"
		              ]
		            },
		            "reducer": {
		              "params": [],
		              "type": "avg"
		            },
		            "type": "query"
		          }
		        ],
		        "executionErrorState": "alerting",
		        "for": "5m",
		        "frequency": "1m",
		        "handler": 1,
		        "name": "CPULA 1/5/15 alert",
		        "noDataState": "no_data",
		        "notifications": []
		      },
		      "aliasColors": {},
		      "bars": false,
		      "dashLength": 10,
		      "dashes": false,
		      "datasource": null,
		      "fieldConfig": {
		        "defaults": {
		          "custom": {}
		        },
		        "overrides": []
		      },
		      "fill": 1,
		      "fillGradient": 0,
		      "gridPos": {
		        "h": 9,
		        "w": 12,
		        "x": 0,
		        "y": 8
		      },
		      "hiddenSeries": false,
		      "id": 2,
		      "legend": {
		        "avg": false,
		        "current": false,
		        "max": false,
		        "min": false,
		        "show": true,
		        "total": false,
		        "values": false
		      },
		      "lines": true,
		      "linewidth": 1,
		      "nullPointMode": "null",
		      "options": {
		        "alertThreshold": true
		      },
		      "percentage": false,
		      "pluginVersion": "7.4.0",
		      "pointradius": 2,
		      "points": false,
		      "renderer": "flot",
		      "seriesOverrides": [],
		      "spaceLength": 10,
		      "stack": false,
		      "steppedLine": false,
		      "targets": [
		        {
		          "expr": "node_load1{instance=\"nodeexporter:9100\", job=\"nodeexporter\"}",
		          "interval": "",
		          "legendFormat": "LA1",
		          "refId": "A"
		        },
		        {
		          "expr": "node_load5{instance=\"nodeexporter:9100\", job=\"nodeexporter\"}",
		          "hide": false,
		          "interval": "",
		          "legendFormat": "LA5",
		          "refId": "B"
		        },
		        {
		          "expr": "node_load15{instance=\"nodeexporter:9100\", job=\"nodeexporter\"}",
		          "hide": false,
		          "interval": "",
		          "legendFormat": "LA15",
		          "refId": "C"
		        }
		      ],
		      "thresholds": [
		        {
		          "colorMode": "critical",
		          "fill": true,
		          "line": true,
		          "op": "gt",
		          "value": 2.5,
		          "visible": true
		        }
		      ],
		      "timeFrom": null,
		      "timeRegions": [],
		      "timeShift": null,
		      "title": "CPULA 1/5/15",
		      "tooltip": {
		        "shared": true,
		        "sort": 0,
		        "value_type": "individual"
		      },
		      "type": "graph",
		      "xaxis": {
		        "buckets": null,
		        "mode": "time",
		        "name": null,
		        "show": true,
		        "values": []
		      },
		      "yaxes": [
		        {
		          "$$hashKey": "object:55",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        },
		        {
		          "$$hashKey": "object:56",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        }
		      ],
		      "yaxis": {
		        "align": false,
		        "alignLevel": null
		      }
		    },
		    {
		      "alert": {
		        "alertRuleTags": {},
		        "conditions": [
		          {
		            "evaluator": {
		              "params": [
		                28698899497
		              ],
		              "type": "lt"
		            },
		            "operator": {
		              "type": "and"
		            },
		            "query": {
		              "params": [
		                "A",
		                "5m",
		                "now"
		              ]
		            },
		            "reducer": {
		              "params": [],
		              "type": "avg"
		            },
		            "type": "query"
		          }
		        ],
		        "executionErrorState": "alerting",
		        "for": "5m",
		        "frequency": "1m",
		        "handler": 1,
		        "name": "/dev/sda8 alert",
		        "noDataState": "no_data",
		        "notifications": []
		      },
		      "aliasColors": {},
		      "bars": false,
		      "dashLength": 10,
		      "dashes": false,
		      "datasource": null,
		      "fieldConfig": {
		        "defaults": {
		          "color": {},
		          "custom": {},
		          "thresholds": {
		            "mode": "absolute",
		            "steps": []
		          },
		          "unit": "bytes"
		        },
		        "overrides": []
		      },
		      "fill": 1,
		      "fillGradient": 0,
		      "gridPos": {
		        "h": 8,
		        "w": 12,
		        "x": 12,
		        "y": 8
		      },
		      "hiddenSeries": false,
		      "id": 6,
		      "legend": {
		        "avg": false,
		        "current": false,
		        "max": false,
		        "min": false,
		        "show": true,
		        "total": false,
		        "values": false
		      },
		      "lines": true,
		      "linewidth": 1,
		      "nullPointMode": "null",
		      "options": {
		        "alertThreshold": true
		      },
		      "percentage": false,
		      "pluginVersion": "7.4.0",
		      "pointradius": 2,
		      "points": false,
		      "renderer": "flot",
		      "seriesOverrides": [],
		      "spaceLength": 10,
		      "stack": false,
		      "steppedLine": false,
		      "targets": [
		        {
		          "expr": "node_filesystem_free_bytes{device=\"/dev/sda8\", fstype=\"ext4\", instance=\"nodeexporter:9100\", job=\"nodeexporter\", mountpoint=\"/\"}",
		          "interval": "",
		          "legendFormat": "",
		          "refId": "A"
		        }
		      ],
		      "thresholds": [
		        {
		          "colorMode": "critical",
		          "fill": true,
		          "line": true,
		          "op": "lt",
		          "value": 28698899497,
		          "visible": true
		        }
		      ],
		      "timeFrom": null,
		      "timeRegions": [],
		      "timeShift": null,
		      "title": "/dev/sda8",
		      "tooltip": {
		        "shared": true,
		        "sort": 0,
		        "value_type": "individual"
		      },
		      "type": "graph",
		      "xaxis": {
		        "buckets": null,
		        "mode": "time",
		        "name": null,
		        "show": true,
		        "values": []
		      },
		      "yaxes": [
		        {
		          "$$hashKey": "object:962",
		          "format": "bytes",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        },
		        {
		          "$$hashKey": "object:963",
		          "format": "short",
		          "label": null,
		          "logBase": 1,
		          "max": null,
		          "min": null,
		          "show": true
		        }
		      ],
		      "yaxis": {
		        "align": false,
		        "alignLevel": null
		      }
		    }
		  ],
		  "refresh": false,
		  "schemaVersion": 27,
		  "style": "dark",
		  "tags": [],
		  "templating": {
		    "list": []
		  },
		  "time": {
		    "from": "now-30m",
		    "to": "now"
		  },
		  "timepicker": {},
		  "timezone": "",
		  "title": "my_dashboard",
		  "uid": "t9jDywE7z",
		  "version": 9
		}
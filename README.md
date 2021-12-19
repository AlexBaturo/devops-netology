    1. TASK [Print OS] ****************************************************************************************************************
        ok: [localhost] => {
            "msg": "Ubuntu"
        }

        TASK [Print fact] **************************************************************************************************************
        ok: [localhost] => {
            "msg": 12
        }

    4.  ok: [centos7] => {
        "msg": "el"
        }
        ok: [ubuntu] => {
            "msg": "deb"
        }

    5.  ok: [centos7] => {
        "msg": "el default fact"
        }
        ok: [ubuntu] => {
            "msg": "deb default fact"
        }

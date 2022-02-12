node("docker"){
    stage("Clean prev build"){
        sh "rm -r ./*"
    }
    stage("Git checkout"){
        git branch: 'main', credentialsId: 'github', url: 'git@github.com:AlexBaturo/devops-netology.git'
    }
    stage("Run playbook"){
            sshagent(credentials: ['my_ssh_cred']){
                sh 'ansible-galaxy install -r requirements.yml -p ./roles'
                sh 'mkdir files'
            }
           
            mode = prod_run.toBoolean() ? "" : "--check --diff"
            ansiblePlaybook(
                playbook: 'site.yml',
                inventory: 'inventory/prod/hosts.yml',
                credentialsId: 'my_ssh_cred',
                disableHostKeyChecking: true,
                colorized: true,
                extras: mode)
        }
        
    }
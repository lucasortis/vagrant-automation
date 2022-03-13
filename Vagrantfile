Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"

    config.vm.provider "virtualbox" do |vb|
        vb.memory = 512
        vb.cpus = 1
    end

        # config.vm.define "mysqldb" do |mysqldb|
        #     mysqldb.vm.network "forwarded_port", guest: 80, host: 8089
        #     mysqldb.vm.network "public_network", ip: "192.168.15.10"
    
        #     mysqldb.vm.synced_folder ".", "/vagrant", disabled: true
        #     mysqldb.vm.synced_folder "./configs", "/configs"
    
        #     mysqldb.vm.provision "shell", path: "~/ambiente_dev/bionic/configs/script.sh"
        # end

        config.vm.define "phpweb" do |phpweb|
            phpweb.vm.provider "virtualbox" do |vb|
                vb.memory = 1024
                vb.cpus = 1
                vb.name = "ubuntu_bionic_php7"
            end

            phpweb.vm.network "forwarded_port", guest: 8888, host: 8888
            phpweb.vm.network "public_network", ip: "192.168.15.11"

            phpweb.vm.provision "shell", inline: "apt-get update && apt-get install -y puppet"

            phpweb.vm.provision "puppet" do |puppet|
                puppet.manifests_path = "./configs/manifests"
                puppet.manifest_file = "phpweb.pp"
            end
        end
        
        config.vm.define "mysqlserver" do |mysqlserver|
            mysqlserver.vm.provider "virtualbox" do |vb|
                vb.name = "ubuntu_bionic_mysqlserver"
            end

            mysqlserver.vm.network "forwarded_port", guest: 80, host: 8089 
            mysqlserver.vm.network "public_network", ip: "192.168.15.10"
            
            mysqlserver.vm.synced_folder ".", "/vagrant", disabled: true
            mysqlserver.vm.synced_folder "./configs", "/configs"    
        end        

        config.vm.provision "ansible" do |ansible|
            ansible.playbook = "./configs/ansible/playbook.yaml"
        end
    
        config.vm.define "memcached" do |memcached|
            memcached.vm.box = "centos/7"
            memcached.vm.provider "virtualbox" do |vb|
                vb.memory = 512
                vb.cpus = 1
                vb.name = "centos7_memcached"
            end
        end

end
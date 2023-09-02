# vi: set ft=ruby :

home = ENV["HOME"]
user = ENV["USER"]
vhome = ENV["VAGRANT_HOME"]

Vagrant.configure("2") do |config|

  config.vm.define "vm1" do |vm1|
    vm1.vm.provider :libvirt do |domain|
      domain.machine_arch = "x86_64"
    end

    vm1.vm.box = "generic/ubuntu1804"
    vm1.vm.hostname = "vm1"
    vm1.vm.network "private_network", ip: "192.168.100.100"
  end

  config.vm.define "vm2" do |vm2|
    vm2.vm.provider :libvirt do |domain|
      domain.machine_arch = "x86_64"
    end

    vm2.vm.box = "generic/ubuntu1804"
    vm2.vm.hostname = "vm2"
    vm2.vm.network "private_network", ip: "192.168.100.101"
  end

  config.vm.define "vm3" do |vm3|
    vm3.vm.provider :libvirt do |domain|
      domain.machine_arch = "x86_64"
    end

    vm3.vm.box = "debian/bullseye64"
    vm3.vm.hostname = "vm3"
    vm3.vm.network "private_network", ip: "192.168.100.102"
    vm3.nfs.verify_installed = false
    vm3.vm.synced_folder '.', '/vagrant', disabled: true   
  end

  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "vagrant_inventory.yml"
    ansible.playbook = "vagrant_provision.yml"
    ansible.vault_password_file = ENV["ANSIBLE_VAULT_PASSWORD_FILE"]
  end

  config.ssh.insert_key = false
  config.ssh.private_key_path = [ "#{home}/.ssh/id_rsa", 
                                  "#{vhome}/insecure_private_key" ]

  # Nomad HTTP endpoint
  config.vm.network "forwarded_port", guest: 4646, host: 4646,
    host_ip: "127.0.0.1",
    auto_correct: true

  config.vm.network "forwarded_port", guest: 4443, host: 4443,
    host_ip: "127.0.0.1",
    auto_correct: true

  config.vm.network "forwarded_port", guest: 8080, host: 8080,
    host_ip: "127.0.0.1",
    auto_correct: true

  config.vm.provider "libvirt" do |libvirt|
    libvirt.memory = 1024
  end

  config.vm.ignore_box_vagrantfile = true

end

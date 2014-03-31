# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
Vagrant.configure("2") do |config|
	config.vm.box 		= "base"
	config.vm.box_url 	= "http://files.vagrantup.com/precise32.box"
	config.ssh.forward_agent = true

	config.vm.network :forwarded_port, guest: 80, host: 8081
	config.vm.synced_folder "www", "/var/www", {:mount_options => ['dmode=777','fmode=777']}

	#config.vm.hostname = "laravel"

	config.vm.provision :puppet do |puppet|
		puppet.manifests_path 	= "C:/Users/ktzaman/Desktop/Intengo/puppet/manifests"
        puppet.manifest_file  	= "init.pp"
        puppet.module_path 		= "C:/Users/ktzaman/Desktop/Intengo/puppet/modules"
        #puppet.options 			= "--verbose --debug"
	end
end

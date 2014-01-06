#http://docs.puppetlabs.com/references/latest/type.html#exec
#rm -rf .vagrant/ www/ logs/ && mkdir www logs
#This is the default puppet file. It gits ran first and start the provisioning sequence.
#Add your creds to the git pull if using the intengo module

# Enable XDebug ("0" | "1")
$use_xdebug = "0"

# Default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin", "/usr/local/rvm/bin/rvm"]
}

exec { 'apt-get update':
        command => '/usr/bin/apt-get update',
        require => Exec['add php55 apt-repo']
}



include bootstrap   	#Sets the fullyqualified domain name and some basics
include other       	#curl and sqlite
include rvm 			#Install ruby & rvm
include php55       	#Make sure the python software props are added so you can go to the latest version of PHP
include php         	#All the wonderful default PHP setup stuff
include apache      	#All the apache settings ( ensures php and php-cli are installed before hand )
include mysql       	#Installs the mysql package, sets default db and pw
include phpmyadmin
include nodejs 			#install node, npm, and grunt
include redis
include intengo 		#Intengo specific project setup. See module for details
include shell 			#Sets some enviromental defaults ( Aliases and such )

#include laravel4   	#Installs a clean laravel repo availible at localhost:8081
#include post_install 	#Configures the ipfw local firewall on a mac to bypass port 8081
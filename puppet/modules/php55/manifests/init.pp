#This file esentially adds the python software props and the newest version of PHP55
class php55 {

	package {"python-software-properties":
			ensure => present
	}

	exec { 'add php55 apt-repo':
			command => 'add-apt-repository ppa:ondrej/php5 -y',
			require => Package['python-software-properties']
	}

	exec { "php55 apt update":
		command => 'apt-get update',
		require => [Exec['add php55 apt-repo']]
	}
}
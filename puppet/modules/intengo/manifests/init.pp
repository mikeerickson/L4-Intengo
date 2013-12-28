class intengo {

	package { 'git-core':
    	ensure => present,
    }

   	exec { "install composer":
	    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin',
	    require => Package['php5-cli'],
	    unless => "[ -f /usr/local/bin/composer ]"
	}

	exec { "global composer":
		command => "sudo mv /usr/local/bin/composer.phar /usr/local/bin/composer",
		require => Exec['install composer'],
		unless => "[ -f /usr/local/bin/composer ]"
	}

	exec { "clean www directory":
		command => "rm -rf /vagrant/www && mkdir /vagrant/www",
		require => Package['apache2']
	}

	exec { "Grab the intengo repo":
		command => "git clone https://github.com/Infosurv/icev2.git /vagrant/www",
		require => [Exec['clean www directory'], Package['php5'], Package['git-core']]
	}

	exec { "update packages":
        command => "/bin/sh -c 'cd /var/www/ && composer --verbose --prefer-dist update'",
        require => [Package['git-core'], Package['php5'], Exec['global composer']],
        onlyif => [ "test -f /var/www/composer.json", "test -d /var/www/vendor" ],
        timeout => 900
	}

	exec { "install packages":
		cwd		=> "/var/www",
        command => "/bin/sh -c 'sudo composer install'",
        require => [Package['git-core'], Exec['update packages'], Exec['Grab the intengo repo']],
        onlyif 	=> [ "test -f /var/www/composer.json" ],
        creates => "/var/www/vendor/autoload.php",
        timeout => 900
	}

	file { '/var/www/app/storage':
		mode => 0777
	}
}
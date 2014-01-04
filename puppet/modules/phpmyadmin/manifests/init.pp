class phpmyadmin {

    package { "phpmyadmin":
            ensure  => present,
            require => [
                Exec['apt-get update'],
                Package["php5", "php5-mysql", "apache2", "mysql-server"],
            ]
    }

    file { "/etc/apache2/conf-enabled/phpmyadmin.conf":
            ensure => link,
            target => "/etc/phpmyadmin/apache.conf",
            require => Package['apache2', 'phpmyadmin'],
            notify => Service["apache2"]
    }

    file { "/etc/phpmyadmin/config.inc.php":
            ensure  => present,
            owner => root, group => root,
            mode => '0775',
            notify  => Service['apache2'],
            source  => 'puppet:///modules/phpmyadmin/config.inc.php',
            require => [Package['phpmyadmin'], Package['apache2'], Package['php5'], Package['php5-cli']],
    }

}
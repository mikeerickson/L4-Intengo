class other
{
    #package { "curl": ensure  => present, require => Exec['apt-get update'] }
    #package { "git-core": ensure => present }
    package { "make": ensure => installed }
    package { "g++": ensure => installed }
    package { "vim": ensure  => present, require => Exec['apt-get update'] }
    package { "sqlite": ensure  => present, require => Exec['apt-get update'] }
}
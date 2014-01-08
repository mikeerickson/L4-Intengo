#https://github.com/blt04/puppet-rvm/blob/master/manifests/system.pp
#rvm ruby-1.9.3-p484 do rvm gemset create ice (Creates the ice gemset)
#rvm use ruby-1.9.3-p484 --install --default

class rvm($version=undef, $install_rvm=true) {
	stage { 'rvm-install': before => Stage['main'] }

	if $install_rvm {
		class {
			'rvm::dependencies': stage => 'rvm-install';
			'rvm::system':       stage => 'rvm-install', version => $version;
		}
		#Install some Ruby versions
		rvm_system_ruby {
			'ruby-1.9.3-p484':
				ensure => 'present',
				default_use => true;
		}

		#Creates the ice gemset
		exec { "create the default gemset":
			command => "/usr/local/rvm/bin/rvm ruby-1.9.3-p484 do rvm gemset create ice",
			require => Rvm_system_ruby['ruby-1.9.3-p484'],
		}

		#Use the gemset
		exec { "use the ice gemset":
			command =>"/usr/local/rvm/bin/rvm use 1.9.3@ice",
			require => Exec['create the default gemset']
		}

		#Install Deps
		exec { "install deps":
			command => "/bin/sh -c 'sudo /usr/local/rvm/gems/ruby-1.9.3-p484@global/bin/bundle install'",
			require => Exec['create the default gemset'],
			timeout => 0,
			logoutput => true
		}

		#Install some gems
		rvm_gem { 'sass':
		    name => 'sass',
		    ruby_version => 'ruby-1.9.3-p484',
		    ensure => latest,
		    require => Rvm_system_ruby['ruby-1.9.3-p484'];
		}
	}
}

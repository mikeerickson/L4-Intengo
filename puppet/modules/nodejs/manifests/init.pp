#http://ariejan.net/2011/10/24/installing-node-js-and-npm-on-ubuntu-debian/
#https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager

class nodejs {
	#command => "/bin/sh -c 'cd /usr/local/bin; git clone https://github.com/joyent/node.git nodejs; cd nodejs; sudo ./configure; sudo make; sudo make install;'",
	exec { "Install Node":
		command => "/bin/sh -c 'git clone https://github.com/joyent/node.git nodejs && cd nodejs && sudo ./configure && sudo make install'",
		timeout => 0
	}

	exec { "install npm":
		command => "/bin/sh -c 'cd /usr/local/bin && curl https://npmjs.org/install.sh | sudo clean=no sh'",
		require => [Exec['Install Node']],
		timeout => 0,
		logoutput => true
	}

	exec { "install grunt cli":
		command => "/bin/sh -c 'sudo /usr/local/bin/npm install -g grunt-cli'",
		require => [Exec['install npm']],
		timeout => 0
	}

	exec { "install dependencies":
		command => "/bin/sh -c 'cd /vaw/www && sudo /usr/local/bin/npm install'",
		require => Exec['install grunt cli']
	}
}
class apt {

	always_apt_update => true,	

	exec { "apt-update":
		command => "/usr/bin/apt-get update"
	}
}


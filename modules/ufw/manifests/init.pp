# Original module from https://usgcb.nist.gov/usgcb/rhel/download_rhel5.html
class ufw {
        package {
                "ufw":
                        ensure	=> "latest";
        }

        service {
                "ufw":
                        ensure    => "true",
                        enable    => "true",
                        provider  => "systemd",
                        require   => Package["ufw"];
        }

	Exec {
			path	=> "/usr/sbin/:/bin/",
	}

	exec { 
		"ufw enable":
			command => "ufw enable",
			require => Package["ufw"];
	}

	exec {
		"ssh":
			command	=> "ufw allow 22/tcp",
			unless	=> "ufw status verbose|grep 22/tcp",
			require	=> Package["openssh-server"];
	}

	exec {
		"ssh-limit":
			command => "ufw limit 22/tcp",
			unless	=> "ufw status verbose|grep 22/tcp |grep 'LIMIT IN'",
			require => Package["openssh-server"];
	}
}

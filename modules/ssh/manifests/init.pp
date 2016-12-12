class ssh {

        package {
                "openssh-client":
                        ensure => latest;
                "openssh-server":
                        ensure => latest;
        }

        service {
                "sshd":
                        ensure    => "true",
                        enable    => "true",
                        provider  => "systemd",
                        require   => Package["openssh-server"];
        }

        augeas {
                "sshd_config":
                        context => "/files/etc/ssh/sshd_config",
                        lens    => "sshd.lns",
                        incl    => "/etc/ssh/sshd_config",
                        changes => [
                                "set Protocol 2",
                                "set ClientAliveInterval 900",
                                "set ClientAliveCountMax 0",
                                "set IgnoreRhosts yes",
                                "set HostbasedAuthentication no",
                                "set PermitRootLogin no",
                                "set PermitEmptyPasswords no",
                                "set PermitUserEnvironment no",
                                "set Ciphers/1 aes128-ctr",
                                "set Ciphers/2 aes192-ctr",
                                "set Ciphers/3 aes256-ctr",
				"set Ciphers/4 arcfour256",
				"set Ciphers/5 arcfour128",
				"set Ciphers/6 arcfour",
				"set Banner /etc/ssh/sshd-banner",
                        ];
        }

	file {
		"/etc/ssh/sshd-banner":
			owner	=> "root",
			group	=> "root",
			mode	=> "0644",
			content	=> template("ssh/sshd-banner"),
			require	=> Package["openssh-server"],
			notify	=> Service["sshd"];
	}
}

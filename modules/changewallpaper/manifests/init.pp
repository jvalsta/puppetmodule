class changewallpaper {

	file {["/etc/skel/.config/","/etc/skel/.config/xfce4/","/etc/skel/.config/xfce4/xfconf/","/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/"]:
		ensure => directory,
	}

        file { "/usr/share/xfce4/backdrops/ESO_NASA_3440x1440.jpg":
                source => "/etc/puppet/modules/changewallpaper/ESO_NASA_3440x1440.jpg",
        }

	file { "/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml":
		content => template("changewallpaper/xfce4-desktop.xml"),
		require => File["/etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/"],
	}
}


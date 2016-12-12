class tools {
	
	$paketit = ['tree','htop','nmap','git']
	
	
	
        package {
		$paketit:
			ensure	=> "latest";
        }
}

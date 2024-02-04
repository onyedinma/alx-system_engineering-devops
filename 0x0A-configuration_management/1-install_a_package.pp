#Installs puppet-lint

package { 'python3-pip':
  ensure => present,  # Ensure pip3 is installed
}

python::pip { 'flask':
  ensure       => '2.1.0',  # Specify version 2.1.0
  pkgname      => 'Flask',  # Package name in pip
  pip_provider => 'pip3',  # Use pip3 for installation
}

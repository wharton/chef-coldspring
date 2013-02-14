# Coldspring Attributes
default['coldspring']['install_path'] = "/vagrant/frameworks"
default['coldspring']['owner'] = node['cf10']['installer']['runtimeuser']
default['coldspring']['group'] = "bin"
default['coldspring']['download']['url'] = "http://www.coldspringframework.org/downloads/coldspring1-2-final.zip"
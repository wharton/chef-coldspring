Description
===========

Installs the Coldspring framework for ColdFusion.

Requirements
============

Cookbooks
---------

coldfusion902

Attributes
==========

* `node['coldspring']['install_path']` (Default is /vagrant/frameworks)
* `node['coldspring']['download']['url']` (Default is http://www.coldspringframework.org/downloads/coldspring1-2-final.zip)

Usage
=====

On ColdFusion server nodes:

    include_recipe "coldspring"



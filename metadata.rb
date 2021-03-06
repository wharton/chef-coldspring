maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "wilburnc@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs/Configures ColdSpring 1.2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.1"

%w{ centos redhat ubuntu }.each do |os|
  supports os
end

depends "coldfusion10"

recipe "default", "installs coldspring 1.2 and adds mapping."

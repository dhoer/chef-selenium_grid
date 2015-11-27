name 'selenium_grid'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures Selenium-Grid'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.2.1'

supports 'centos'
supports 'redhat'
supports 'mac_os_x'
supports 'ubuntu'
supports 'windows'

depends 'selenium', '~> 3.1'
depends 'apt', '~> 2.0'
depends 'yum', '~> 3.0'
depends 'xvfb', '~> 2.0'
depends 'mozilla_firefox', '~> 1.0'
depends 'chrome', '~> 1.0'
depends 'chromedriver', '~> 1.0'
depends 'iedriver', '~> 1.0'
depends 'ghostdriver', '~> 1.0'
depends 'opera', '~> 1.1'
depends 'operadriver', '~> 1.0'
depends 'safaridriver', '~> 1.0'
depends 'windows_screenresolution', '~> 1.0'

source_url 'https://github.com/dhoer/chef-selenium_grid' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-selenium_grid/issues' if respond_to?(:issues_url)

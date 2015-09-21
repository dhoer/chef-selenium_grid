name 'selenium_grid'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs/Configures Selenium-Grid'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

supports 'centos'
supports 'redhat'
supports 'mac_os_x'
supports 'ubuntu'
supports 'windows'

depends 'selenium', '~> 3.0'
depends 'firefox', '~> 2.0'
depends 'chrome', '~> 1.0'
depends 'chromedriver', '~> 1.0'
depends 'iedriver', '~> 1.0'
depends 'ghostdriver', '~> 1.0'
depends 'safaridriver', '~> 1.0'
depends 'xvfb', '~> 2.0'
depends 'windows_screenresolution', '~> 1.0'
depends 'windows', '~> 1.38'
depends 'nssm', '~> 1.0'
depends 'apt', '~> 2.0'
depends 'yum', '~> 3.0'
depends 'dmg', '~> 2.0'
depends 'macosx_autologin', '~> 3.0'
depends 'macosx_gui_login', '~> 1.0'

source_url 'https://github.com/dhoer/chef-selenium_grid' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-selenium_grid/issues' if respond_to?(:issues_url)

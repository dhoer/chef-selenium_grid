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

depends 'selenium'
depends 'firefox', '~> 2.0'
depends 'chrome', '~> 1.0'
depends 'chromedriver', '~> 1.0'
depends 'iedriver', '~> 1.0'
depends 'safaridriver', '~> 1.0'
depends 'xvfb'
depends 'windows_screenresolution'
depends 'windows', '~> 1.37.0' # 1.38 spams warning about windows_reboot being removed
depends 'nssm'
depends 'apt'
depends 'yum'
depends 'dmg'
depends 'macosx_autologin'
depends 'macosx_gui_login'

source_url 'https://github.com/dhoer/chef-selenium_grid' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-selenium_grid/issues' if respond_to?(:issues_url)

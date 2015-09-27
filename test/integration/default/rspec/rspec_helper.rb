require 'rspec'
require 'selenium-webdriver'

LINUX = RbConfig::CONFIG['host_os'].downcase =~ /linux/
MACOSX = RbConfig::CONFIG['host_os'].downcase =~ /darwin/
WINDOWS = RbConfig::CONFIG['host_os'] =~ /mingw|mswin/

RSpec.configure { |c| c.formatter = 'documentation' }

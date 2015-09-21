require 'rspec'
require 'selenium-webdriver'
require 'ffi'

WINDOWS = FFI::Platform.windows?
MAC = FFI::Platform.mac?

RSpec.configure { |c| c.formatter = 'documentation' }

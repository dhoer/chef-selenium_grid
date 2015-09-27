require 'rspec_helper'
require 'rbconfig'

if WINDOWS || RbConfig::CONFIG['host_os'] =~ /linux/ && `gcc --version` =~ /Ubuntu/
  describe 'Opera Grid' do
    before(:all) do
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
      if WINDOWS
        binary = 'C:\Program Files (x86)\Opera\launcher.exe'
      else
        binary = '/usr/bin/opera'
      end
      caps[:chromeOptions] = { binary: binary }
      caps[:browserName] = 'operablink'
      @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: caps)
    end

    after(:all) do
      @selenium.quit
    end

    if MACOSX
      res = '1024 x 768'
    else
      res = '1280 x 1024' # xvfb
    end

    it "Should return display resolution of #{res}" do
      @selenium.get 'http://www.whatismyscreenresolution.com/'
      element = @selenium.find_element(:id, 'resolutionNumber')
      expect(element.text).to eq(res)
    end
  end
end

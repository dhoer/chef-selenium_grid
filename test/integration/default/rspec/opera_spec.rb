require 'rspec_helper'
require 'rbconfig'

if WINDOWS || (LINUX && `gcc --version` =~ /Ubuntu/)
  describe 'Opera Grid' do
    before(:all) do
      caps = Selenium::WebDriver::Remote::Capabilities.chrome
      binary = WINDOWS ? 'C:\Program Files (x86)\Opera\launcher.exe' : '/usr/bin/opera'
      caps[:chromeOptions] = { binary: binary }
      caps[:browserName] = 'operablink'
      @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: caps)
    end

    after(:all) do
      @selenium.quit
    end

    res = MACOSX ? '1024 x 768' : '1280 x 1024'

    it "Should return display resolution of #{res}" do
      @selenium.get 'http://www.whatismyscreenresolution.com/'
      element = @selenium.find_element(:id, 'resolutionNumber')
      expect(element.text).to eq(res)
    end
  end
end

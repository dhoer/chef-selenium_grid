require 'rspec_helper'

describe 'IE Grid', if: WINDOWS do
  before(:all) do
    @selenium = Selenium::WebDriver.for(:remote, desired_capabilities: :ie)
  end

  after(:all) do
    @selenium.quit
  end

  it 'Should return display resolution of 1280 x 1024' do
    @selenium.get 'http://www.whatismyscreenresolution.com/'
    element = @selenium.find_element(:id, 'resolutionNumber')
    expect(element.text).to eq('1280 x 1024')
  end
end

username = platform?('windows', 'mac_os_x') ? node['selenium_grid']['username'] : nil
password = platform?('windows', 'mac_os_x') ? node['selenium_grid']['password'] : nil
domain = platform?('windows') ? node['selenium_grid']['domain'] : nil

width = node['selenium_grid']['display']['width']
height = node['selenium_grid']['display']['height']

case node['platform_family']
when 'debian'
  # firefox runs at compile time and firefox package is not up to date on Ubuntu 14.04-1
  execute 'sudo apt-get update' do
    action :nothing
  end.run_action(:run)
when 'rhel'
  include_recipe 'yum'
end

unless platform?('windows', 'mac_os_x')
  node.override['xvfb']['dimensions'] = "#{width}x#{height}x#{node['selenium_grid']['display']['depth']}"

  include_recipe 'xvfb'
end

capabilities = []

# chrome not supported on rhel 6
if node['selenium_grid']['chrome']['max_instances'] > 0 && !(platform_family?('rhel') &&
  node['platform_version'].split('.')[0] == '6')
  include_recipe 'chrome'
  include_recipe 'chromedriver'
  v_chrome = node['selenium_grid']['chrome']['version']
  capabilities << {
    browserName: 'chrome',
    maxInstances: node['selenium_grid']['chrome']['max_instances'],
    version: v_chrome ? v_chrome : chrome_version,
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['firefox']['max_instances'] > 0
  node.set['mozilla_firefox']['32bit_only'] = true
  include_recipe 'mozilla_firefox'
  v_firefox = node['selenium_grid']['firefox']['version']
  capabilities << {
    browserName: 'firefox',
    maxInstances: node['selenium_grid']['firefox']['max_instances'],
    version: v_firefox ? v_firefox : firefox_version,
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['htmlunit']['max_instances'] > 0
  capabilities << {
    browserName: 'htmlunit',
    maxInstances: node['selenium_grid']['htmlunit']['max_instances'],
    version: node['selenium_grid']['htmlunit']['version'],
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['ie']['max_instances'] > 0 && platform?('windows')
  raise('Only one instance of ie allowed!') if node['selenium_grid']['ie']['max_instances'] > 1
  include_recipe 'iedriver'
  v_ie = node['selenium_grid']['ie']['version']
  capabilities << {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: v_ie ? v_ie : ie_version,
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['opera']['max_instances'] > 0 && platform?('ubuntu', 'windows')
  include_recipe 'opera'
  include_recipe 'operadriver'
  v_opera = node['selenium_grid']['opera']['version']
  capabilities << {
    browserName: 'operablink',
    maxInstances: node['selenium_grid']['opera']['max_instances'],
    version: v_opera ? v_opera : opera_version,
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['phantomjs']['max_instances'] > 0 && !platform?('mac_os_x', 'windows')
  node['selenium_grid']['phantomjs']['max_instances'].times do |i|
    ghostdriver "ghostdriver_node_#{i}" do
      webdriver "#{node['ipaddress']}:#{8910 + i}"
      host = node['selenium']['node']['hubHost'] == 'ip' ? node['ipaddress'] : node['selenium']['node']['hubHost']
      port = node['selenium']['node']['hubPort']
      webdriverSeleniumGridHub "http://#{host}:#{port}"
      action :install
    end
  end
end

if node['selenium_grid']['safari']['max_instances'] > 0 && platform?('mac_os_x')
  node.set['safaridriver']['username'] = username
  node.set['safaridriver']['password'] = password
  include_recipe 'safaridriver'
  v_safari = node['selenium_grid']['safari']['version']
  capabilities << {
    browserName: 'safari',
    maxInstances: node['selenium_grid']['safari']['max_instances'],
    version: v_safari ? v_safari : safari_version,
    seleniumProtocol: 'WebDriver'
  }
end

unless capabilities.empty?
  node.set['selenium']['node']['capabilities'] = capabilities
  node.set['selenium']['node']['username'] = username
  node.set['selenium']['node']['password'] = password
  node.set['selenium']['node']['domain'] = domain

  include_recipe 'selenium::node'
end

# Call windows_display after selenium_node because windows_display will
# override auto-login created by selenium_node.
if node['selenium_grid']['display']['windows'] && platform?('windows')
  node.set['windows_screenresolution']['username'] = username
  node.set['windows_screenresolution']['password'] = password
  node.set['windows_screenresolution']['width'] = width
  node.set['windows_screenresolution']['height'] = height

  include_recipe 'windows_screenresolution'
end

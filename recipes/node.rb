username = platform?('windows', 'mac_os_x') ? node['selenium_grid']['username'] : nil
password = platform?('windows', 'mac_os_x') ? node['selenium_grid']['password'] : nil
domain = platform?('windows') ? node['selenium_grid']['domain'] : nil

width = node['selenium_grid']['display']['width']
height = node['selenium_grid']['display']['height']

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
  v_chrome = node['selenium_grid']['firefox']['version']
  capabilities << {
    browserName: 'chrome',
    maxInstances: node['selenium_grid']['chrome']['max_instances'],
    version: v_chrome ? v_chrome : chrome_version,
    seleniumProtocol: 'WebDriver'
  }
end

if node['selenium_grid']['firefox']['max_instances'] > 0 && !platform?('debian')
  include_recipe 'firefox'
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
  fail('Only one instance of ie allowed!') if node['selenium_grid']['ie']['max_instances'] > 1
  include_recipe 'iedriver'
  v_ie = node['selenium_grid']['ie']['version']
  capabilities << {
    browserName: 'internet explorer',
    maxInstances: 1,
    version: v_ie ? v_ie : ie_version,
    seleniumProtocol: 'WebDriver'
  }
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

node.set['selenium']['node']['capabilities'] = capabilities
node.set['selenium']['node']['username'] = username
node.set['selenium']['node']['password'] = password
node.set['selenium']['node']['domain'] = domain

include_recipe 'selenium::node'

# Call windows_display after selenium_node because windows_display will
# override auto-login created by selenium_node.
if node['selenium_grid']['display']['windows'] && platform?('windows')
  node.set['windows_screenresolution']['username'] = username
  node.set['windows_screenresolution']['password'] = password
  node.set['windows_screenresolution']['width'] = width
  node.set['windows_screenresolution']['height'] = height

  include_recipe 'windows_screenresolution'
end
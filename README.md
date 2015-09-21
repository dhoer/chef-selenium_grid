# Selenium-Grid Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/selenium_grid.svg?style=flat-square)][supermarket]
[![Build Status](http://img.shields.io/travis/dhoer/chef-selenium_grid.svg?style=flat-square)][travis]

[supermarket]: https://supermarket.chef.io/cookbooks/selenium_grid
[travis]: https://travis-ci.org/dhoer/chef-selenium_grid

Wraps selenium, browser, driver, and screenresolution cookbooks into one comprehensive cookbook.

Supports

- Chrome
- Firefox
- HtmlUnit
- Internet Explorer
- PhantomJS
- Safari

## Requirements

- Java (not installed by this cookbook)
- Chef 11.16+ 

### Platforms

- CentOS, RedHat
- Mac OS X
- Ubuntu
- Windows

### Cookbooks

- windows
- nssm - Required by Windows services only (e.g. Hub and HtmlUnit running in background)
- macosx_autologin - Required by Mac OS X GUI services 

## Recipes

## hub

Installs and configures a Selenium Hub as a service.

## node

Installs and configures a Selenium Node as service on Linux and a GUI service on Mac OS X and Windows.

### Attributes

- `node['selenium_grid']['username']` - Mac OS X and Windows. Default `nil`.
- `node['selenium_grid']['password']` - Mac OS X and Windows. Default `nil`.
- `node['selenium_grid']['domain']` - Windows only. Default `nil`.
- `node['selenium_grid']['display']['width']` - Screen resolution width. Linux and Windows only. Default `1024`.
- `node['selenium_grid']['display']['height']` - Screen resolution height. Linux and Window only. Default `768`.
- `node['selenium_grid']['display']['depth']` - Screen resolution depth. Linux only. Default `24`.
- `node['selenium_grid']['display']['windows']` - Set Windows screen resolution. Windows only. Default `true`.
- `node['selenium_grid']['chrome']['max_instances']` - Installs Chrome and ChromeDriver, if > 0. Default `0`.
- `node['selenium_grid']['chrome']['version']` - Version of browser installed, if nil. Default `nil`.
- `node['selenium_grid']['firefox']['max_instances']` - Installs Firefox, if > 0. Default `0`.
- `node['selenium_grid']['firefox']['version']` - Version of browser installed, if nil. Default `nil`.
- `node['selenium_grid']['htmlunit']['max_instances']` - Activates HtmlUnit, if > 0. Default `0`.
- `node['selenium_grid']['htmlunit']['version']` - Default `nil`.
- `node['selenium_grid']['ie']['max_instances']` - Installs IEDriver and configures IE, if > 0. Only one instance
of IE is recommended. Windows only. Default `0`.
- `node['selenium_grid']['ie']['version']` - Version of browser installed, if nil. Default `nil`.
- `node['selenium_grid']['phantomjs']['max_instances']` - Creates a separate Node service for each instance, 
if > 0. Linux only. Default `0`.
- `node['selenium_grid']['safari']['max_instances']` - Installs SafariDriver, if > 0. Mac OS X only. Default `0`.
- `node['selenium_grid']['safari']['version']` - Version of browser installed, if nil. Default `nil`.
    
### Examples

#### Selenium Node with Chrome and Firefox capabilities

```ruby
node.set['selenium_grid']['chrome']['max_instances'] = 5
node.set['selenium_grid']['firefox']['max_instances'] = 5
  
include_recipe 'selenium::node'
```

#### Selenium Node with IE capability and custom version

```ruby
v = ie_version.split('.')
major_version = v[0]
minor_version = v[1]

node.set['selenium_grid']['ie']['max_instances'] = 1
node.set['selenium_grid']['ie']['version'] = "#{major_version}.#{minor_version}"
  
include_recipe 'selenium::node'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/selenium).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-selenium_grid/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-selenium_grid/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-selenium_grid/blob/master/LICENSE.md) file for details.

# Selenium-Grid Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/selenium_grid.svg?style=flat-square)][cookbook]
[![linux](http://img.shields.io/travis/dhoer/chef-selenium_grid/master.svg?label=linux&style=flat-square)][linux]
[![win](https://img.shields.io/appveyor/ci/dhoer/chef-selenium-grid/master.svg?label=windows&style=flat-square)][win]

[cookbook]: https://supermarket.chef.io/cookbooks/selenium_grid
[linux]: https://travis-ci.org/dhoer/chef-selenium_grid/branches
[win]: https://ci.appveyor.com/project/dhoer/chef-selenium-grid


Setup a selenium grid in minutes.  Create selenium hub, then add selenium nodes on Linux, Mac OS X and/or Windows 
platforms.  Set max instances greater than zero to install and/or configure Browsers and JavaScript engines.  Browsers 
and JavaScript engines will be ignored on operating systems that are not compatible. 

Supported Browser and JavaScript engines:

- Chrome
- Firefox
- HtmlUnit
- Internet Explorer

## Requirements

- Java (not installed by this cookbook)
- Chef 12.14+ 

### Platforms

- CentOS, RedHat
- Debian, Ubuntu
- Windows

## Recipes

## hub

Installs and configures a Selenium Hub as a service.  See selenium 
[hub](https://github.com/dhoer/chef-selenium#attributes-1)
recipe attributes for more information about configuring the hub.

## node

Installs and configures a Selenium Node as service on Linux and a GUI service on Windows. See selenium
[node](https://github.com/dhoer/chef-selenium#attributes-2) recipe attributes for more information about configuring 
the node. The following attributes are in addition to the node attributes. See associated browsers and drivers cookbook 
attributes (if any) for more information about configuring them as well.

### Attributes

- `node['selenium_grid']['chrome']['max_instances']` - Installs 
[Chrome](https://github.com/dhoer/chef-chrome#attributes) and 
[ChromeDriver](https://github.com/dhoer/chef-chromedriver#attributes), if > 0. Default `0`.
- `node['selenium_grid']['chrome']['version']` - Version of browser installed, if nil. Default `nil`.
- `node['selenium_grid']['firefox']['max_instances']` - Installs 
[MozillaFirefox](https://github.com/dhoer/chef-mozilla_firefox#attributes), if > 0. Default `0`.
- `node['selenium_grid']['firefox']['version']` - Version of browser installed, if nil. Default `nil`.
- `node['selenium_grid']['htmlunit']['max_instances']` - Activates HtmlUnit, if > 0. Default `0`.
- `node['selenium_grid']['htmlunit']['version']` - Default `nil`.
- `node['selenium_grid']['ie']['max_instances']` - Installs 
[IEDriver](https://github.com/dhoer/chef-iedriver#attributes) and configures 
[IE](https://github.com/dhoer/chef-ie#ie-cookbook), if > 0. Only one instance
of IE is recommended. Windows only. Default `0`.
- `node['selenium_grid']['ie']['version']` - Version of browser installed, if nil. Default `nil`.

##### Account

- `node['selenium_grid']['username']` - Windows only. Default `nil`.
- `node['selenium_grid']['password']` - Windows only. Default `nil`.
- `node['selenium_grid']['domain']` - Windows only. Default `nil`.

##### Display

- `node['selenium_grid']['display']['width']` - Linux and Windows only. Default `1024`.
- `node['selenium_grid']['display']['height']` - Linux and Window only. Default `768`.
- `node['selenium_grid']['display']['depth']` - Linux only. Default `24`.
- `node['selenium_grid']['display']['windows']` - Windows only. Default `true`.
    
### Examples

#### Role to create Selenium Node with Chrome and Firefox capabilities

```ruby
name "selenium_node"
description "Install Selenium Node with Chrome and Firefox capabilities"
default_attributes(
  "selenium_grid": {
    "chrome": {
      "max_instances": 5
    },
    "firefox": {
      "max_instances": 5
    } 
  }
)
run_list(
  "recipe[selenium_grid::node]"
)
```

#### Selenium Node with IE capability and custom version

```ruby
v = ie_version.split('.')
major_version = v[0]
minor_version = v[1]

node.set['selenium_grid']['ie']['max_instances'] = 1
node.set['selenium_grid']['ie']['version'] = "#{major_version}.#{minor_version}"
  
include_recipe 'selenium_grid::node'
```

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/selenium).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-selenium_grid/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-selenium_grid/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-selenium_grid/blob/master/LICENSE.md) file for details.

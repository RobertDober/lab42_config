# lab42\_config

[![Build Status](https://travis-ci.org/RobertDober/lab42_config.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_config)

Refactor your configuration away

## Configure a Class

```ruby
    class Commiter
      include Lab42::Config
      config do 
        dvs "github"
        status :commiter
      end
    end
```

For details see the corresponding [QED demo](https://github.com/RobertDober/lab42_config/blob/master/demo/class.md).


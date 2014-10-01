
# lab42\_config

## Configuring a Class

The configuration values will serve as defaults for all instances.

```ruby
    class Commiter
      include Lab42::Config
      configure do 
        dvs "github"
        status :commiter
      end
    end
```

Now the `configuration` instance method gives access to these values

```ruby
    Commiter.new.tap do | comm |
      comm.configuration.dvs.assert == 'github'
      comm.configuration.status.assert == :commiter
    end
```



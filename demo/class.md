
# lab42\_config

## Configuring a Class

The configuration values will serve as defaults for all instances.

```ruby
    class Commiter
      include Lab42::Config
      config do 
        dvs "github"
        status :commiter
      end
    end
```

Now the `configuration` instance method gives access to these values

```ruby
    comm = Commiter.new
    comm.configuration.dvs.assert == 'github'
    comm.configuration.status.assert == :commiter
```

### Changing on instance level is not possible

```ruby
    c = Commiter.new
    
    NoMethodError.assert.raised? do
      c.configuration.dvs "bitbucket"
    end
```

### Nor is adding new values

```ruby
      NoMethodError.assert.raised? do
        c.configuration.commits 42
      end
```

As a matter of fact one should not use configuration but instance data, like so

```ruby
    class Comitter
      include Lab42::Config
      config do 
        dvs "github"
        status :commiter
      end
        attr_writer :dvs
        def dvs; @dvs || configuration.dvs end
    end

    c1 = Comitter.new
    c2 = Comitter.new
    c1.dvs.assert == 'github'
    c1.dvs = 'bitbucket'
    c2.dvs.assert == 'github'
    c1.dvs.assert == 'bitbucket'
```

## However Classes can reopen the config


This is a typical use case, ship a class in a _gem_ and allow reconfiguration
of default values.

```ruby
    # A Shell class provided by a gem with reasonable defaults
    class Shell
      include Lab42::Config
      config do
        home{ File.join "home", user }
      end
      def user; 'robert' end
    end

    Shell.new.configuration.home.assert == File.join('home', 'robert')
```

Now a consumer of this API might want to work on a different OS

```ruby
    Shell.config do
      home{ File.join "u", user }
    end
    Shell.new.configuration.home.assert == File.join('u', 'robert')
```




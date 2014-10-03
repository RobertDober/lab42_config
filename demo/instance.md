# lab42\_config

## Instances accessing the configuration

It is not by chance that the access to configuration data at the instance level is done
with the rather bulky `configuration` method.

In general configuration shall not be used in business logic all the time, however configuration
data is surely often needed. So what?

Well this gem puts emphasis on the fact, that, if configuration data is needed regulary it should
be treated as first level instance data.

This can be achieved manually easily enough:

```ruby
    class Device
      include Lab42::Config
      config do
        udev_base '/dev/disk'
        by_id{ File.join configuration.udev_base, 'by-id' }
      end
      # Now the dull staff
      extend Forwarder
      forward_all :by_id, :udev_base, to: :configuration
    end
```

of course access is easy now

```ruby
    Device.new.udev_base.assert == '/dev/disk'
```


So Ruby's delegation mechanisme (and the faster and more readable `forwarder2` gem if I might be so blunt)
make this easy (though still redundant).

### And modifying them locally...

But what if we want instance local modifications, now the code must be augmented differently

```ruby
    class Device
      config do
        usb_devices{ File.join path, 'usb-devices' }
        path '/usr/bin'
      end
      def path
        # Careful with nil and false values here
        instance_variable_defined?( :@path ) ? @path : configuration.path
      end
    end
```

**N.B.** The omission of `configuration.` before `path` by anticipating the creation of an access method to it

```ruby
    class Device
      forward :usb_devices, to: :configuration
      attr_writer :path # a rare use case, but in this manner we can overwrite the default
    end
```

This does a nice job, but is not very readable or DRY

```ruby
    d1 = Device.new
    d1.path = '/usr/local/bin'
    d1.usb_devices.assert = File.join( '/usr/local/bin', 'usb-devices' )
    d2 = Device.new
    d2.usb_devices.assert = File.join( '/usr/bin', 'usb-devices' )
    
```

In order to facilitate this kind of configuration exposure we introduce the concept of


### Instance Configuration

where an _Instance_ _Configuration_ is a class configuration value that can be accessed directly as a method
by the instance and can also be set locally.

The instance variables used under the hood are namespaced but hidden and augment the readability and DRYness of the code

```ruby
    class Word
      attr_reader :word

      include Lab42::Config
      config do
        lang 'en-us'
        prefix :un
      end
      instance_config :lang, :prefix
      
      def negate; "#{prefix}#{word}" end

      private
      def initialize word
        @word = word
      end
    end
```

Now we have

```ruby
    w1 = Word.new 'reasonable'
    w2 = Word.new 'correct'
    w2.prefix = :in
    
    w1.negate.assert == 'unreasonable'
    w2.negate.assert == 'incorrect'

```


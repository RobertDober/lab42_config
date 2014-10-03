require 'spec_helper'


describe Lab42::Config::InstanceLevelConfig do
  let :klass do
    Class.new do
      include Lab42::Config
      config do
        value 42
        result{ configuration.value * factor }
      end
      def factor; 2 end
    end
  end
  
  let( :receiver ){ klass.new } 
  
  let( :instance ){ klass.__config__.instance_level_config receiver}

  it_behaves_like 'BasicObject protected methods'

  context 'allows to read values' do
    it{ expect( instance.value ).to eq 42 }
    it{ expect( instance.result ).to eq 84 }
  end # context 'allows to set values'

  context 'raises error for unexisting keys' do 
    it{ expect{ instance.xxx }.to raise_error NoMethodError, /xxx/ }
  end # context 'raises error for unexisting keys'

  context 'does not allow to set them' do 
    it{ expect{ instance.value 44 }.to raise_error NoMethodError, /value/ }
  end # context 'does not allow to read them'

end # describe Lab42::Config::Instance


require 'spec_helper'

describe Lab42::Config::ClassLevelConfig do
  let( :instance ){ described_class.new }

  it_behaves_like 'BasicObject protected methods'

  context 'allows to set values' do
    it{ expect{ instance.value 42 }.not_to raise_error }
    it{ expect{ instance.value{ 42 } }.not_to raise_error }
  end # context 'allows to set values'

  context 'does not allow to read them' do 
    it{ expect{ instance.value }.to raise_error NoMethodError, /value/ }
  end # context 'does not allow to read them'

end # describe Lab42::Config::Instance

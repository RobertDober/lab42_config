require 'spec_helper'
describe Lab42::Config do 
  context 'configuration defined on class level' do 
    let( :klass ){ 
      Class.new do
        include Lab42::Config
        config do
          value 42
          name "answer"
        end
      end
    }

    context 'can be accessed on instance level' do 
      it{ expect( klass.new.configuration.value ).to eq 42 }
      it{ expect( klass.new.configuration.name ).to eq "answer" }
    end # context 'can be accessed on instance level'
    
  end # context 'on class level'
end # describe Lab42::Config

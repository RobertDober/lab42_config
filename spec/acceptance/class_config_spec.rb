require 'spec_helper'
describe Lab42::Config do 
  context 'configuration defined on class level' do 
    shared_examples_for 'config with default values' do
      it{ expect( klass.new.configuration.value ).to eq 42 }
      it{ expect( klass.new.configuration.name ).to eq "answer" }
    end # context 'can be accessed on instance level'

    let( :klass ){ 
      Class.new do
        include Lab42::Config
        config do
          value 42
          name "answer"
        end
      end
    }

    it_behaves_like 'config with default values'

    context 'it cannot be' do 
      let( :obj ){ klass.new.configuration }
      it 'overwritten on instance level' do
        expect{ obj.value 43 }.to raise_error NoMethodError, /value/ 
      end
      it 'created on instance level' do
        expect{ obj.new_value 43 }.to raise_error NoMethodError, /new_value/ 
      end
    end # context 'it cannot be'

    context 'it can be reopened on class level' do 
      it 'to change a value' do
        klass.config{ value 52 }
        expect( klass.new.configuration.value ).to eq 52
      end
      it 'to add a value' do
        klass.config{ age 52 }
        expect( klass.new.configuration.age ).to eq 52
      end

    end # context 'it can be reopened on class level'
  end # context 'on class level'
end # describe Lab42::Config

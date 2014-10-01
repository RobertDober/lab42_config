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
        expect{ obj.value 43 }.to raise_error RuntimeError, /can't modify/
      end
      it 'created on instance level' do
        expect{ obj.new_value 43 }.to raise_error RuntimeError, /can't modify/
      end
      it 'cannot be reopened' do
        expect do
          klass.config{ age 52 }
        end.to raise_error RuntimeError, /can't modify/ 
      end
    end # context 'it cannot be overwritten on instance level'
  end # context 'on class level'
end # describe Lab42::Config

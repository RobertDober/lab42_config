require 'spec_helper'

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

describe Lab42::Config do 
  context 'instance_config' do 
    let( :pleasant ){ Word.new :pleasant }
    let( :correct ){ Word.new :correct }
    
    it 'negates pleasant correctly and correct incorrectly' do
      expect( pleasant.negate ).to eq 'unpleasant'
      expect( correct.negate ).to eq 'uncorrect'
    end

    it 'negates both correctly after adjusting correct correctly' do
      correct.prefix = :in
      expect( pleasant.negate ).to eq 'unpleasant'
      expect( correct.negate ).to eq 'incorrect'
    end

    it 'setting has no influce on new instances either' do
      correct.prefix = :in
      expect( Word.new('').prefix ).to eq :un
    end

  end # context 'instance_config'
end # describe Lab42::Config

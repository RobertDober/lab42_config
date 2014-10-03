
shared_examples_for 'BasicObject protected methods' do
  it 'still has ==' do
    expect{ instance.== }.to raise_error ArgumentError
    expect( instance == instance ).to eq true
    expect( instance == 43 ).to eq false
  end
  it 'still has equal?' do
    expect{ instance.equal? }.to raise_error ArgumentError
    expect( instance.equal? instance ).to eq true
    expect( instance.equal? 43 ).to eq false
  end
  it 'still has !=' do
    expect{ instance.!= }.to raise_error ArgumentError
    expect( instance != instance ).to eq false
    expect( instance != 43 ).to eq true
  end
  it 'still has !' do
    expect{ instance.! 42 }.to raise_error ArgumentError
  end
  it 'still has __id__' do
    expect{ instance.__id__ 42 }.to raise_error ArgumentError
  end
  it 'still has __send__' do
    expect{ instance.__send__ :a }.to raise_error NoMethodError
  end
  it 'still has instance_eval' do
    instance.instance_eval '42'
    expect{ instance.instance_eval }.to raise_error ArgumentError
    expect( instance.instance_eval{ self } ).to eq instance
  end
  it 'still has instance_exec' do
    expect{ instance.instance_exec }.to raise_error LocalJumpError
    expect{ instance.instance_exec '42' }.to raise_error LocalJumpError
    expect( instance.instance_exec{ self } ).to eq instance
  end
end 

require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/spacecraft'


RSpec.describe Spacecraft do
  it 'initializes' do
    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})

    expect(daedalus.class).to eq(Spacecraft)
    expect(daedalus.name).to eq('Daedalus')
    expect(daedalus.fuel).to eq(400)
  end

end

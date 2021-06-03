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

    expect(daedalus.requirements.class).to eq(Array)
    expect(daedalus.requirements.length).to eq(0)
  end

  it 'can add requirements' do
    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})

    requirements = [{astrophysics: 6}, {quantum_mechanics: 3}]
    requirements.each { |requirement| daedalus.add_requirement(requirement) }

    expect(daedalus.requirements.length).to eq(2)
    expect(daedalus.requirements.first).to eq(requirements[0])
    expect(daedalus.requirements.last).to eq(requirements[1])
  end

end

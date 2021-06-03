require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/person'
require_relative '../lib/spacecraft'
require_relative '../lib/flotilla'


RSpec.describe Flotilla do
  it 'initializes' do
    seventh_flotilla = Flotilla.new({designation: 'Seventh Flotilla'})

    expect(seventh_flotilla.class).to eq(Flotilla)
    expect(seventh_flotilla.designation).to eq('Seventh Flotilla')

    expect(seventh_flotilla.personnel.class).to eq(Array)
    expect(seventh_flotilla.personnel.length).to eq(0)

    expect(seventh_flotilla.ships.class).to eq(Array)
    expect(seventh_flotilla.ships.length).to eq(0)
  end

  it 'can add ships' do
    seventh_flotilla = Flotilla.new({designation: 'Seventh Flotilla'})
    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})

    seventh_flotilla.add_ship(daedalus)
    expect(seventh_flotilla.ships.first.class).to eq(Spacecraft)
    expect(seventh_flotilla.ships.length).to eq(1)
  end

  it 'can add and recommend personnel' do
    seventh_flotilla = Flotilla.new({designation: 'Seventh Flotilla'})

    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})
    requirements = [{astrophysics: 6}, {quantum_mechanics: 3}]
    requirements.each { |requirement| daedalus.add_requirement(requirement) }

    seventh_flotilla.add_ship(daedalus)

    john = Person.new('John Doe', 10)
    specialties = [:astrophysics, :quantum_mechanics]
    specialties.each { |specialty| john.add_specialty(specialty) }

    sampson = Person.new('Sampson Edwards', 7)
    specialties.each { |specialty| sampson.add_specialty(specialty) }

    polly = Person.new('Polly Parker', 8)
    specialties = [:operations, :maintenance]
    specialties.each { |specialty| polly.add_specialty(specialty) }

    rover = Person.new('Rover Henriette', 1)
    specialties.each { |specialty| rover.add_specialty(specialty) }

    personnel = [john, sampson, polly, rover]
    personnel.each { |person| seventh_flotilla.add_personnel(person) }

    expect(seventh_flotilla.personnel.length).to eq(4)
    data_validation = seventh_flotilla.personnel.all? do |person|
      person.class == Person
    end
    expect(data_validation).to be(true)

    recommendation = seventh_flotilla.recommend_personnel(daedalus)
    expect(recommendation.class).to eq(Array)
    expect(recommendation.length).to eq(2)
    expect(recommendation.first.name).to eq('John Doe')
    expect(recommendation.last.name).to eq('Sampson Edwards')

    odyssey = Spacecraft.new({name: 'Odyssey', fuel: 300})
    requirements = [{operations: 6}, {maintenance: 3}]
    requirements.each { |requirement| odyssey.add_requirement(requirement) }
    seventh_flotilla.add_ship(odyssey)

    recommendation = seventh_flotilla.recommend_personnel(odyssey)
    expect(recommendation.class).to eq(Array)
    expect(recommendation.length).to eq(1)
    expect(recommendation.first.name).to eq('Polly Parker')
  end

  it 'can group qualified personnel by ship' do
    seventh_flotilla = Flotilla.new({designation: 'Seventh Flotilla'})

    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})
    requirements = [{astrophysics: 6}, {quantum_mechanics: 3}]
    requirements.each { |requirement| daedalus.add_requirement(requirement) }
    seventh_flotilla.add_ship(daedalus)

    odyssey = Spacecraft.new({name: 'Odyssey', fuel: 300})
    requirements = [{operations: 6}, {maintenance: 3}]
    requirements.each { |requirement| odyssey.add_requirement(requirement) }
    seventh_flotilla.add_ship(odyssey)

    john = Person.new('John Doe', 10)
    specialties = [:astrophysics, :quantum_mechanics]
    specialties.each { |specialty| john.add_specialty(specialty) }

    sampson = Person.new('Sampson Edwards', 7)
    specialties.each { |specialty| sampson.add_specialty(specialty) }

    polly = Person.new('Polly Parker', 8)
    specialties = [:operations, :maintenance]
    specialties.each { |specialty| polly.add_specialty(specialty) }

    rover = Person.new('Rover Henriette', 1)
    specialties.each { |specialty| rover.add_specialty(specialty) }

    personnel = [john, sampson, polly, rover]
    personnel.each { |person| seventh_flotilla.add_personnel(person) }


    grouping = seventh_flotilla.personnel_by_ship
    expect(grouping.class).to eq(Hash)
    expect(grouping.keys.length).to eq(2)
    expect(grouping.keys.first.class).to eq(Spacecraft)
    expect(grouping.keys.last.class).to eq(Spacecraft)

    expect(grouping.values.length).to eq(2)
    expect(grouping.values.first.class).to eq(Array)
    expect(grouping.values.first.length).to eq(2)
    expect(grouping.values.first.first.name).to eq('John Doe')
    expect(grouping.values.first.last.name).to eq('Sampson Edwards')

    expect(grouping.values.last.class).to eq(Array)
    expect(grouping.values.last.length).to eq(1)
    expect(grouping.values.last.first.name).to eq('Polly Parker')
  end

  it 'can return ships ready for travel as per ship requirements' do
    seventh_flotilla = Flotilla.new({designation: 'Seventh Flotilla'})

    daedalus = Spacecraft.new({name: 'Daedalus', fuel: 400})
    requirements = [{astrophysics: 6}, {quantum_mechanics: 3}]
    requirements.each { |requirement| daedalus.add_requirement(requirement) }
    seventh_flotilla.add_ship(daedalus)

    odyssey = Spacecraft.new({name: 'Odyssey', fuel: 300})
    requirements = [{operations: 6}, {maintenance: 3}]
    requirements.each { |requirement| odyssey.add_requirement(requirement) }
    seventh_flotilla.add_ship(odyssey)

    john = Person.new('John Doe', 10)
    specialties = [:astrophysics, :quantum_mechanics]
    specialties.each { |specialty| john.add_specialty(specialty) }

    sampson = Person.new('Sampson Edwards', 7)
    specialties.each { |specialty| sampson.add_specialty(specialty) }

    polly = Person.new('Polly Parker', 5)
    specialties = [:operations, :maintenance]
    specialties.each { |specialty| polly.add_specialty(specialty) }

    rover = Person.new('Rover Henriette', 1)
    specialties.each { |specialty| rover.add_specialty(specialty) }

    personnel = [john, sampson, polly, rover]
    personnel.each { |person| seventh_flotilla.add_personnel(person) }


    recommendation = seventh_flotilla.ready_ships(350)
    expect(recommendation.class).to eq(Array)
    expect(recommendation.length).to eq(1)
    expect(recommendation.first.name).to eq('Daedalus')

    recommendation = seventh_flotilla.ready_ships(200)
    expect(recommendation.class).to eq(Array)
    expect(recommendation.length).to eq(2)
    expect(recommendation.first.name).to eq('Daedalus')
    expect(recommendation.last.name).to eq('Odyssey')
  end


end

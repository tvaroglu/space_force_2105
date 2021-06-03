require 'simplecov'
SimpleCov.start

require 'rspec'
require_relative '../lib/person'


RSpec.describe Person do
  it 'initializes' do
    person = Person.new('John Doe', 10)

    expect(person.class).to eq(Person)
    expect(person.name).to eq('John Doe')
    expect(person.experience).to eq(10)

    expect(person.specialties.class).to eq(Array)
    expect(person.specialties.length).to eq(0)
  end

  it 'can add specialties' do
    person = Person.new('John Doe', 10)

    specialties = [:astrophysics, :quantum_mechanics]
    specialties.each { |specialty| person.add_specialty(specialty) }

    expect(person.specialties.length).to eq(2)
    expect(person.specialties.first).to eq(specialties[0])
    expect(person.specialties.last).to eq(specialties[1])
  end

end

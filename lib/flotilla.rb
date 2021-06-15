class Flotilla
  attr_reader :designation, :personnel, :ships

  def initialize(attributes)
    @designation = attributes[:designation]
    @personnel = Array.new
    @ships = Array.new
  end

  def add_ship(ship)
    @ships << ship if ship.class == Spacecraft
  end

  def add_personnel(person)
    @personnel << person if person.class == Person
  end

  def recommend_personnel(ship)
    requirements = ship.requirements.map { |requirement| requirement.values.first }
    personnel = @personnel.select { |person| person.experience >= requirements.max_by { |req| req } }
    personnel.select do |person|
      person.specialties.all? { |specialty| ship.requirements.to_s.include?(specialty.to_s) }
    end
  end

  def personnel_by_ship
    @ships.each_with_object({}) { |ship, hash| hash[ship] = recommend_personnel(ship) }
  end

  def ready_ships(minimum_fuel)
    result_arr = Array.new
    personnel_by_ship.each do |ship, qualified_personnel|
      result_arr << ship if qualified_personnel.length > 0 && ship.fuel >= minimum_fuel
    end
    result_arr
  end

end

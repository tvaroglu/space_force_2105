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
    result_arr = Array.new
    ship.requirements.each do |requirement|
      @personnel.each do |person|
        person.specialties.each do |specialty|
          if specialty == requirement.keys.first && person.experience >= requirement.values.first
            result_arr << person
          end
        end
      end
    end
    result_arr.uniq
  end

  def personnel_by_ship
    @ships.each_with_object({}) { |ship, hash| hash[ship] = recommend_personnel(ship) }
  end

  def ready_ships(minimum_fuel)
    result_arr = Array.new
    groupings = personnel_by_ship
    groupings.each do |ship, qualified_personnel|
      if qualified_personnel.length > 0 && ship.fuel >= minimum_fuel
        result_arr << ship
      end
    end
    result_arr
  end

end

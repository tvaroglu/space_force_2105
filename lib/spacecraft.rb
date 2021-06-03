class Spacecraft
  attr_reader :name, :fuel, :requirements

  def initialize(attributes)
    @name = attributes[:name]
    @fuel = attributes[:fuel]
    @requirements = Array.new
  end

  def add_requirement(requirement)
    @requirements << requirement
  end

end

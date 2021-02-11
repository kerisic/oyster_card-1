class Journey
  attr_reader :entry_station, :exit_station

  MINFARE = 1
  PENALTY = 6

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def complete?
    @entry_station && @exit_station ? true : false
  end

  def end(exit_station)
    @exit_station = exit_station
    self
  end

  def fare
    complete? ? MINFARE : PENALTY
  end
end

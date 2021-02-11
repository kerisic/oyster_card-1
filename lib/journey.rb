class Journey
  attr_reader :entry_station, :exit_station, :in_journey

  MINFARE = 1
  PENALTY = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
    @in_journey = true
  end

  def complete?
    !@in_journey && @entry_station && @exit_station ? true : false
  end

  def end(exit_station)
    @exit_station = exit_station
    @in_journey = false
    self
  end

  def fare
    complete? ? MINFARE : PENALTY
  end
end

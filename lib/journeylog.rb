require_relative 'journey'

class JourneyLog
  def initialize(journeyclass = Journey)
    @journeyclass = journeyclass
    @journeys = []
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def start(entrystation)
    @current_journey = @journeyclass.new(entrystation)
    @journeys << @current_journey
    @in_journey = true
  end

  def finish(exit_station)
    currentjourney
    @journeys << @current_journey if @current_journey.entry_station.nil?
    @current_journey.end(exit_station)
    @current_journey = nil
    @in_journey = false
  end

  def journeys
    @journeys.dup
  end

  private

  def currentjourney
    @current_journey ||= @journeyclass.new
  end
end

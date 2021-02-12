require_relative 'journeylog'

class Oystercard
  attr_reader :balance

  MAXAMOUNT = 90
  MINAMOUNT = 1
  MINFARE = 1

  def initialize(journey_log = JourneyLog.new)
    @balance = 0
    @journey_list = []
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "reached topup limit of #{MAXAMOUNT}!" if @balance + amount > MAXAMOUNT

    @balance += amount
  end

  def touch_in(entry_station)
    raise "You have less than #{MINAMOUNT} on your card" if @balance < MINAMOUNT

    deduct @journey_log.journeys.last.fare if @journey_log.in_journey?
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    @journey_log.finish(exit_station)
    deduct(@journey_log.journeys.last.fare)
  end

  def journey_history
    @journey_log.journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end

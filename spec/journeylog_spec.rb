require 'journeylog'

describe JourneyLog do
  let(:station) { double :station }
  let(:journey) { spy :journey, start: nil }
  let(:journey_class) { double :journey_class, new: journey }
  subject { JourneyLog.new(journey_class) }

  describe '#start' do
    before(:each) { subject.start(station) }

    it 'should start a journey' do
      expect(journey_class).to have_received(:new).with(station)
    end

    it 'records a journey' do
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    it 'should pass exit station to journey' do
      subject.start(station)
      subject.finish(station)
      expect(journey).to have_received(:end).with(station)
    end
  end

  describe '#journeys' do
    it 'show the journey history' do
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys).to include(journey)
    end
  end
end

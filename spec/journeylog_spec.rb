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
      expect(subject.journeys).to include journey
    end

    it 'should be in journey' do
      expect(subject).to be_in_journey
    end
  end

  describe '#finish' do
    before(:each) do
      subject.start(station)
      subject.finish(station)
    end

    it 'should pass exit station to journey' do
      expect(journey).to have_received(:end).with(station)
    end

    it 'should not be in journey' do
      expect(subject).not_to be_in_journey
    end
  end
end

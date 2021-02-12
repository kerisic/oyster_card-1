require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:subject) { Journey.new(station) }

  it 'consists of an entry station when starting a journey' do
    expect(subject.entry_station).to eq station
  end

  it 'returns whether if the journey is complete' do
    expect(subject.complete?).to eq false
  end

  it 'returns itself when exiting a journey' do
    expect(subject.end(station)).to eq(subject)
  end

  it 'has a penalty far by default' do
    expect(subject.fare).to eq(6)
  end

  describe 'when starting a journey' do
    subject { described_class.new(station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'returns a penalty fare if there is no exit station in journey' do
      expect(subject.fare).to eq Journey::PENALTY
    end
  end

  describe 'when ending a journey' do
    let(:station2) { double :station2 }
    before(:each) do
      subject.end(station2)
    end

    it 'when ending a journey, save the exit station information' do
      expect(subject.exit_station).to eq(station2)
    end

    it 'when ending a journey, journey becomes complete' do
      expect(subject).to be_complete
    end
  end
end

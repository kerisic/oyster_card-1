require 'journey'

describe Journey do
  let(:subject) { subject = Journey.new('station') }

  it 'consists of an entry station when starting a journey' do
    expect(subject.entry_station).to eq 'station'
  end

  it 'returns whether if the journey is complete' do
    expect(subject.complete?).to eq false
  end

  it 'calculates the penalty fare if journey is not complete' do
    expect(subject.fare).to eq(6)
  end

  describe 'when ending a journey' do
    before(:each) do
      subject.end('nowhere')
    end

    it 'when ending a journey, save the exit station information' do
      expect(subject.exit_station).to eq('nowhere')
    end

    it 'when ending a journey, journey becomes complete' do
      expect(subject).to be_complete
    end

    it 'calculates the fare of a journey when journey is complete' do
      expect(subject.fare).to eq(1)
    end
  end
end

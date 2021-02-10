require 'station'

describe Station do
  let(:station) { Station.new('Green Park', 'zone 1') }

  it 'creates a new station' do
    expect(station).to be_a Station
  end

  it 'has a name' do
    expect(station.name).to eq('Green Park')
  end

  it 'has a zone' do
    expect(station.zone).to eq('zone 1')
  end
end

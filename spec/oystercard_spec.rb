require 'oystercard'

describe Oystercard do
let(:entry_station) {double :entry_station}
let(:exit_station) {double :exit_station}

  it 'should have a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'should respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'should top up by given amount' do
    expect{subject.top_up(20)}.to change{subject.balance}.by(20)
  end

  it 'should not top up beyond £90' do
    maximum_amount = Oystercard.new.maximum_amount
    subject.top_up(maximum_amount)
    expect{subject.top_up(1)}.to raise_error "reached topup limit of #{maximum_amount}!"
  end

  it "should not allow user to touch_in if balance is less than the minimum required" do
    expect { subject.touch_in(entry_station) }.to raise_error "You have less than #{Oystercard::Minimum_amount} on your card"
  end

  # it 'should deduct money by given amount' do
  #   subject.top_up(20)
  #   expect{subject.deduct(10)}.to change{subject.balance}.by(-10)
  # end

  describe 'when touching in and touching out do' do
    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end


  it "deducts minimum fare from @balance when the user touches out" do
    expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-(Oystercard::Minimum_fare))
  end

  it 'can touch in' do
    expect(subject).to be_in_journey
  end


  it "remembers the entry station after the touch in" do
    expect(subject.entry_station).to eq entry_station
  end

it "forgets the entry station on touch out" do
  expect{subject.touch_out(exit_station)}.to change{subject.entry_station}.to nil
end

end

describe 'remember journey information' do
  before(:each) do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
end

it 'remembers the exit station after touch out' do
  expect(subject.exit_station).to eq exit_station
end

it 'remembers a journey history' do
  expect(subject.journey_list).to eq [{entry_station: entry_station, exit_station: exit_station}]
end

it 'should not be in journey' do
  expect(subject).not_to be_in_journey
end

end

it 'should start empty' do
  expect(subject.journey_list).to be_empty
end

end

require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'should have a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'should respond to top_up method' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it 'should top up by given amount' do
    expect { subject.top_up(20) }.to change { subject.balance }.by(20)
  end

  it 'should not top up beyond £90' do
    maximum_amount = Oystercard.new.maximum_amount
    subject.top_up(maximum_amount)
    expect { subject.top_up(1) }.to raise_error "reached topup limit of #{maximum_amount}!"
  end

  it 'should not allow user to touch_in if balance is less than the minimum required' do
    message = "You have less than #{Oystercard::Minimum_amount} on your card"
    expect { subject.touch_in(entry_station) }.to raise_error message
  end

  describe 'when touching in and touching out do' do
    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
    end

    it 'deducts minimum fare from @balance when the user touches out' do
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::Minimum_fare)
    end
  end

  describe 'remember journey information' do
    before(:each) do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
  end

  it 'should start empty' do
    expect(subject.journey_list).to be_empty
  end
end

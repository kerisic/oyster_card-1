require 'oystercard'

describe Oystercard do

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

  it 'should deduct money by given amount' do
    subject.top_up(20)
    expect{subject.deduct(10)}.to change{subject.balance}.by(-10)
  end

  it 'can touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'should not be in journey' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end


end

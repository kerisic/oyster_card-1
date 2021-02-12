require 'oystercard'

describe Oystercard do
  let(:station) { double :station, zone: 1 }
  let(:station1) { double :station1, zone: 1 }

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
    subject.top_up(Oystercard::MAXAMOUNT)
    expect { subject.top_up(1) }.to raise_error "reached topup limit of #{Oystercard::MAXAMOUNT}!"
  end

  it 'should not allow user to touch_in if balance is less than the minimum required' do
    message = "You have less than #{Oystercard::MINAMOUNT} on your card"
    expect { subject.touch_in(station) }.to raise_error message
  end

  it 'should start empty' do
    expect(subject.journey_history).to be_empty
  end

  describe 'when touching-in and touching-out at stations' do
    before(:each) do
      subject.top_up(20)
      subject.touch_in(station)
    end

    describe 'deducting the right fare' do

      it "deducts the mininum fare if it hadn't travelelled across boundary" do
        expect { subject.touch_out(station1) }.to change { subject.balance }.by(-(Oystercard::MINFARE))
      end

      context "deducts the difference between boundaries in addition to min fare" do
        let(:station2) { double :station2, zone: 2 }
        let(:station3) { double :station2, zone: 3 }


        it "deducts 1 more to min fare if 1 zone between boundaries" do
          expect { subject.touch_out(station2) }.to change { subject.balance }.by(-(2))
        end

        it "deducts 2 more to min fare if 2 zones between boundaries" do
          expect { subject.touch_out(station3) }.to change { subject.balance }.by(-(3))
        end
      end

      it "deducts the penalty fare if haven't touched out and touched in again" do
        expect { subject.touch_in(station1) }.to change { subject.balance }.by(-(6))
      end

      it "deducts the penalty fare if touching out without touching in" do
        subject.touch_out(station1)
        expect { subject.touch_out(station1) }.to change { subject.balance }.by(-(6))
      end
    end
  end
end

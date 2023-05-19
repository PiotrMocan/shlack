require 'rails_helper'

describe User, type: :model do
  describe '#create' do
    subject { User.create(user_params) }

    let(:user_params) do
      {
        name:,
        age:,
        gender:
      }
    end
    let(:name) { 'John Doe' }
    let(:age) { 18 }
    let(:gender) { 'female' }

    context 'when name is not present' do
      let(:name) { nil }

      it 'is not valid' do
        expect(subject.errors.to_hash.keys).to include(:name)
      end
    end

    context 'when name is present' do
      let(:name) { 'John Doe' }
      it 'is valid' do
        expect(subject.errors.to_hash.keys).not_to include(:name)
      end
    end

    context 'when age is not present' do
      let(:age) { nil }
      it('is not valid') do
        expect(subject.errors.to_hash.keys).to include(:age)
      end

      it 'does not creates user' do
        expect { subject }.not_to(change { User.count })
      end
    end

    context 'when age is present' do
      context 'when age in range' do
        let(:age) { 18 }
        it 'is valid' do
          expect(subject.errors.to_hash.keys).not_to include(:age)
        end
      end

      context 'when age out of range' do
        let(:age) { 15 }
        it 'is not valid' do
          expect(subject.errors[:age]).to eq(['must be in 16..99'])
        end
      end
    end
    context 'when gender is invalid' do
      let(:gender) { 'invalid' }
      it 'invalid' do
        expect { subject }.to raise_exception(ArgumentError)
      end
    end
  end
end

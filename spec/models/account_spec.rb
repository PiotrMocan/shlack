require 'rails_helper'

RSpec.shared_examples 'invalid email' do
  it 'email is not valid' do
    expect(subject.errors.to_hash.keys).to include(:email)
  end
end

describe Account, type: :model do
  describe '#create' do
    subject { Account.create(user_id:, **create_params) }

    let(:create_params) do
      {
        email:,
        password:
      }
    end
    let(:email) { 'test@gmail.com' }
    let(:password) { 'qwerty12' }
    let!(:user_id) { create(:user, :young).id }

    context 'when user exist' do
      let!(:user_id) { create(:user, :young).id }

      it 'create account' do
        expect { subject }.to change { Account.count }.by(1)
      end
    end

    context 'when user not exist' do
      let!(:user_id) { build(:user).id }
      it 'does not create account' do
        expect { subject }.to_not(change { Account.count })
      end
    end

    context 'when email is not valid' do
      let(:email) { 'test' }

      it_behaves_like 'invalid email'
    end

    context 'when email is valid' do
      let(:email) { 'test@gmail.com' }
      it 'is right format' do
        expect(subject.errors.to_hash.keys).not_to include(:email)
      end

      context 'when email is not unique' do
        before { create(:account, email:) }

        it_behaves_like 'invalid email'
      end
    end
  end
end

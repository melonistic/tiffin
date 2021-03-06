require 'rails_helper'

describe User do

  let(:user) {FactoryBot.create(:user, street_address: '500 Massachusetts Ave.', city: 'Cambridge', state: 'MA', zip_code: '02139')}
  subject {user}

  describe 'associations' do
    it { is_expected.to have_one(:chef) }
    # it { is_expected.to have_many(:page_concurrency_detectors) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email)}
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:role) }
    it { should define_enum_for(:role)}
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:contact_phone) }
    it { is_expected.to validate_presence_of(:street_address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:zip_code) }
  end

  describe '#authenticate' do

    context 'when password is valid' do
      subject {user.authenticate(user.password)}
      it { is_expected.to be_truthy }
    end

    context 'when password is invalid' do
      subject {user.authenticate("goodbye")}
      it { is_expected.to be_falsey }
    end
  end

  describe '#full_name' do
    subject {user.full_name}
    it { is_expected.to eq("#{user.first_name} #{user.last_name}")}
  end

  describe '#distance_to' do
    let(:other_user) {FactoryBot.create(:user, street_address: '1001 Massachusetts Ave.', city: 'Cambridge', state: 'MA', zip_code: '02138', first_name: 'John', last_name: 'Smith', email: 'john@example.com', password: 'security', password_confirmation: 'security')}
    subject {user.distance_to(other_user)}
    it {
      is_expected.to be_within(0.1).of(0.6)
    }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid with valid attributes' do
      user = User.new(
        name: 'John Doe',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid without a password' do
      user = User.new(
        name: 'John Doe',
        email: 'user@example.com'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = User.new(
        name: 'John Doe',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'mismatched_password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is not valid without an email' do
      user = User.new(
        name: 'John Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is not valid if the email is not unique (case insensitive)' do
      existing_user = User.create(
        name: 'John Doe',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        name: 'Jane Doe',
        email: 'USER@example.com',
        password: 'new_password',
        password_confirmation: 'new_password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is not valid without a name' do
      user = User.new(
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'is not valid with a password shorter than 6 characters' do
      user = User.new(
        name: 'John Doe',
        email: 'user@example.com',
        password: 'pass',  # Password length is less than 6 characters
        password_confirmation: 'pass'
      )
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end

  describe 'authenticate_with_credentials' do
    it 'authenticates with leading/trailing spaces in email' do
      user = User.create(
        name: 'John Doe',
        email: 'example@domain.com',
        password: 'password',
        password_confirmation: 'password'
      )
    
      authenticated_user = User.authenticate_with_credentials(' example@domain.com ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates with mixed case email' do
      user = User.create(
        name: 'Jane Doe',
        email: 'eXample@domain.COM',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials('EXAMPLe@DOMAIN.CoM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end

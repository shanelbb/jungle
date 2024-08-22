require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'is valid with a password and password_confirmation' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to be_valid
    end

    it 'is not valid if password and password_confirmation do not match' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'different',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a password' do
      user = User.new(
        email: 'test@test.com',
        password: nil,
        password_confirmation: nil,
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without an email' do
      user = User.new(
        email: nil,
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a first name' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: nil,
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end

    it 'is not valid without a last name' do
      user = User.new(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: nil
      )
      expect(user).to_not be_valid
    end

    it 'is not valid with a duplicate email (case insensitive)' do
      User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      user = User.new(
        email: 'TEST@TEST.COM',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end
  
    it 'is not valid with a password less than 6 characters' do
      user = User.new(
        email: 'test@test.com',
        password: 'short',
        password_confirmation: 'short',
        first_name: 'Test',
        last_name: 'User'
      )
      expect(user).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Test',
        last_name: 'User'
      )
    end

    it 'authenticates with valid credentials' do
      user = User.authenticate_with_credentials('test@test.com', 'password')
      expect(user).to eq(@user)
    end

    it 'does not authenticate with invalid credentials' do
      user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
      expect(user).to be_nil
    end

    it 'authenticates with spaces around email' do
      user = User.authenticate_with_credentials('  test@test.com  ', 'password')
      expect(user).to eq(@user)
    end

    it 'authenticates with different case in email' do
      user = User.authenticate_with_credentials('TeSt@TeSt.CoM', 'password')
      expect(user).to eq(@user)
    end
  end
end


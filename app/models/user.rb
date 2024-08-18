class User < ApplicationRecord
    has_secure_password
  
    
    validates :email, presence: true, uniqueness: true
  
    
    validates :password, length: { minimum: 6, message: 'must be at least 6 characters long' }, if: -> { new_record? || !password.nil? }
    
    
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
  end
  
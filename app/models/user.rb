class User < ActiveRecord::Base
  validates_presence_of :email, :password, :name

  has_secure_password validations: false
end
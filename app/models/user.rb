class User < ApplicationRecord

	has_secure_password
	validates :password, :length => { :in => 8..24 }, :allow_nil => true
	validates_presence_of :email

end

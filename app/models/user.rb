class User < ActiveRecord::Base 
    has_secure_password
    has_many :aerial_entries

    validates :username, presence: true 
    validates :username, uniqueness: true 
end 
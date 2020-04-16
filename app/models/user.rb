class User < ActiveRecord::Base 
    has_secure_password
    
    has_many :aerial_entries

    validates :name, presence: true 
    validates :username, presence: true 
    validates :username, uniqueness: true 
end 
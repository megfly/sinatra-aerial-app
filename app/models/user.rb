class User < ActiveRecord::Base 
    has_secure_password
    has_many :aerial_entries
    #has_one_attached :image

end 
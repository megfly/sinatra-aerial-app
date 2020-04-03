class User < ActiveRecord::Base 
    has_secure_password
    validates :name, presence: true 
    validates :username, presence: true 
    validates :username, uniqueness: true #prevent saving and updating username and name if user doesnt type them in
    has_many :aerial_entries
    #has_one_attached :image

end 
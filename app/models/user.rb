class User < ApplicationRecord
    has_secure_password
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    
    has_many :blog_posts, foreign_key: 'author_id'
end

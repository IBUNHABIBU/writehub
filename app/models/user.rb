class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    format: /\A\S+@\S+\z/
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article
  
    def self.authenticate(email, password)
        user = User.find_by(email: email)
        user && user.authenticate(password)
    end
end

class Account < ApplicationRecord
  enum role: { regular: 'regular', admin: 'admin' }

  has_secure_password
  belongs_to :user
  validates :email, presence: true, uniqueness: true, 'valid_email_2/email': true
  validates :password, presence: true, length: { minimum: 8, maximum: 50 }
end

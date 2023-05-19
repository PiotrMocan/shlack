class User < ApplicationRecord
  has_one :account, dependent: :destroy
  enum gender: { female: 'female', male: 'male', other: 'other' }
  validates :name, presence: true
  validates :age, presence: true, numericality: { in: 16..99 }
end

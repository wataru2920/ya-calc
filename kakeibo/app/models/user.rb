class User < ApplicationRecord
  validates :username,
    presence: true,
    length: {minimum: 1, maximum: 50, allow_blank: true}
  validates :email,
    presence: true,
    length: {minimum: 10, allow_blank: true},
    format: {with: /\A[a-zA-Z0-9]+@[a-zA-Z]+[-]*[a-zA-Z0-9]+\.[a-zA-Z]{2,}\z/, allow_blank: true}
  validates :password,
    presence: true,
    length: {minimum: 8, allow_blank: true}
end

class User < ActiveRecord::Base
  has_secure_password validations: false

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  validates :email, presence: true

  has_many :permissions

  validates_uniqueness_of :email


end

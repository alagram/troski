class User < ActiveRecord::Base
  has_secure_password validations: false

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  validates :email, presence: true


end

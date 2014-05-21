class User < ActiveRecord::Base
  has_secure_password validations: false
  before_create :generate_token

  def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
  end

  validates :email, presence: true

  has_many :permissions

  validates_uniqueness_of :email

  private

  def generate_token
    self.token = SecureRandom.uuid
  end


end

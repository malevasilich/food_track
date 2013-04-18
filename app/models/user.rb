class User < ActiveRecord::Base
  attr_accessible :name, :password_digest
  has_secure_password
  validates_presence_of :password, :on => :create
  attr_accessible :password, :password_confirmation
  validates_confirmation_of :password  
  validates_presence_of :name  
  validates_uniqueness_of :name
  
  def encrypt_password  
    if password.present?  
      self.password_digest = BCrypt::Engine.hash_secret(password)  
    end  
  end    

end

require 'digest/sha1'

class User < ActiveRecord::Base
  
  validates_presence_of       :name
  validates_uniqueness_of     :name
  
  validates_presence_of       :access_level
 	#validates_presence_of			:kennel
 	
  attr_accessor               :password_confirmation
  validates_confirmation_of   :password
  
  validates_presence_of       :email
  
  def validate
    errors.add_to_base("Missing password") if hashed_password.blank?
  end
  
  def self.authenticate(name, password)
    user = self.find_by_name(name)
    if user
      expected_password = encrypted_password(password, user.salt)
      expected_user_level = "admin"
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  def find_kennel_name(cu)
  	self.find_by_sql("select kennel from uses where id = #{cu}")
  end
  
  # 'password' is a virtual attribute
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "wibble" + salt  # 'wibble' makes it harder to guess
    Digest::SHA1.hexdigest(string_to_hash)
  end
    
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end  # <--- end Class

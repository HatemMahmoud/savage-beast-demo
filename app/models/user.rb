class User < ActiveRecord::Base
  include SavageBeast::UserInit
  validates_presence_of :identifier, :username, :email
  validates_uniqueness_of :identifier, :username, :email, :case_sensitive => false
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  
  def display_name
    username
  end
end

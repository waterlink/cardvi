class Card < ActiveRecord::Base
  attr_accessible :content, :name, :user_id

  belongs_to :user
  validates :name, :content, :presence => true
  validates :name, :uniqueness => { :scope => :user_id }
end

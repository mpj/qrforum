class Wall < ActiveRecord::Base
	has_many :posts
	has_many :subscriptions
	validates :title, :presence => true, :length => { :maximum => 75 }
	validates :code, :presence => true
end

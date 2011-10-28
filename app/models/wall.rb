class Wall < ActiveRecord::Base
	has_many :posts
	validates :title, :presence => true, :length => { :maximum => 75 }
	validates :code, :presence => true
end

class Post < ActiveRecord::Base
	belongs_to :wall
	validates :body, :presence => true, :length => { :maximum => 400 }
	validates :signature, :presence => true, :length => { :maximum => 25 }

end

class Subscription < ActiveRecord::Base
	belongs_to :wall
	validates :wall, :presence => true
end

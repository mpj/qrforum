class Subscription < ActiveRecord::Base
	belongs_to :wall, :counter_cache => true
	validates :wall, :presence => true
end

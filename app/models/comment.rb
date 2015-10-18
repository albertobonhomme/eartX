class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :product

	def seconds_ago
		(Time.now - self.updated_at)
	end

	def time_ago
		time = Hash.new
		time[:days] = (seconds_ago / 86400).floor
		time[:hours] = ((seconds_ago % 86400) / 3600).floor
		time[:minutes] = (((seconds_ago % 86400) % 3600) / 60).floor
		
		return time 
	end
end

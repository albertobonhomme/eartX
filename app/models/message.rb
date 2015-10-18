class Message < ActiveRecord::Base
	belongs_to :chat
	belongs_to :user


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

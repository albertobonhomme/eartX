class TicketsController < ApplicationController

	def create
		@ticket = @artwork.tickets.new(ticket_params)
	end

	private

	def ticket_params
		params.require(:ticket).permit(:price,:shares,:buyer,:seller)
	end
end

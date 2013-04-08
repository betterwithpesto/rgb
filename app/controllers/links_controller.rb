class LinksController < ApplicationController
	def create
		@link = Link.new(params[:link])
		if @link.save
			redirect_to edit_url(subdomain: current_user.urlname)
		else
			redirect_to edit_url(subdomain: current_user.urlname)
		end
	end
end
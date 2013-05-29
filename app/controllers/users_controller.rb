class UsersController < ApplicationController

def show
    user = User.find_by_urlname!(request.subdomain)
    @page = PortfolioPage.new(user, params)

    render 'portfolio', layout: user.portfolio_style
end

def edit
    @user = User.find_by_urlname!(request.subdomain)
    @link = Link.where(:user_id => @user.id).all
end

def update
    @user = User.find_by_urlname!(request.subdomain)
    if @user.update_attributes(params[:user])
        redirect_to root_url(:subdomain => false)
    else
        render :edit
    end
end

end
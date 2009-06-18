class UsersController < ApplicationController
  def index
    params[:search] ||= {} 

    @users = User.search(:all, :filters => params[:search])
  end

  def show
  end

end

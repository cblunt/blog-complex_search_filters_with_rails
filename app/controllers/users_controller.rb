class UsersController < ApplicationController
  def index
    params[:search] ||= {} 
    params[:search][:admin] = (params[:search][:admin] == "true" ? true : nil)

    @users = User.search(:all, :filters => params[:search])
  end

  def show
  end

end

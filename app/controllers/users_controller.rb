class UsersController < ApplicationController
  def index
    @users = User.search(:all)
  end

  def show
  end

end

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user, only: %i[show edit update destroy]
  @resdom = ['AI','ML','cloud','Physics']

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @ids = @user.ideas.paginate(page: params[:page], per_page: 12)
  end

  def favourite
  end

  private
  def check_user
    if !current_user.admin?
      if current_user.id != Idea.find(params[:id]).user_id
        render 'home/error'
      end
    end
  end

end
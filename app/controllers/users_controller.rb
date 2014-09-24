class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index, :admin]

  def index
    @user = User.all
  end



  def show
    @user = User.find(params[:id])
    @total = Rating.where('success' => true).count
    myratings = Rating.where('user_id' => current_user.id).where('success' => true)

    @mycount = myratings.count
  end
  def edit
  	@user = User.find(params[:id])
  end
  def call
    @user = User.find(params[:id])
  end


  def admin
    @users = User.all
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  
  end

  private
    def user_params
      params.require(:user).permit(:phone, :nick, :approved)
    end

  end




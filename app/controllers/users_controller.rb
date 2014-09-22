class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user?, :except => [:index]

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  def edit
  	@user = User.find(params[:id])
  end
  def call
    @user = User.find(params[:id])
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

  #def first_name
    #self.name.blank? ? "" : self.name.split(" ")[0]
  #end
  private
    def user_params
      params.require(:user).permit(:phone, :nick)
    end

  end




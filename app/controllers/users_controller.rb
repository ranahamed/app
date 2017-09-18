class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]

  def show
  	@user=User.find(params[:id])
 
  end

  def new
  	@user=User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      log_in @user #login to create session to save data 
      flash[:success]="welcome to the sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

    def user_params # data from post
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

     # Before filters
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "please log in"
        redirect_to login_url
      end
    end

end
class SessionsController < ApplicationController
  def new
  end

  def create
  	user=User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		# Log the user in and redirect to the user's show page.
  		log_in user  #method in helper
  		redirect_back_or user  #if user tried to go to page not logged in url will be saved 
      #and redirected to it after default if no was logging 3ady 7yro7 lldefault #redirect_to user(old)
  	else
  		# Create an error message.
  		flash.now[:danger]= 'Inavlid email/password combination'
        render 'new'
  	end
  	
  end

   def destroy
    log_out
    redirect_to root_url
   end

end



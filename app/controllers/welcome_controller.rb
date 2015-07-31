class WelcomeController < ApplicationController
  def index
    redirect_to registered_applications_path if current_user
  end

  def about
  end

  def help
  end
end

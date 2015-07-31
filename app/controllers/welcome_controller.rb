class WelcomeController < ApplicationController
  def index
    redirect_to getting_started_path if current_user
  end

  def about
  end

  def help
  end
end

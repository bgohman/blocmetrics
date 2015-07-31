class RegisteredApplicationsController < ApplicationController
  def new
    @registered_application = RegisteredApplication.new
    authorize @registered_application
  end

  def create
    @registered_application = RegisteredApplication.new(registered_application_params)
    authorize @registered_application
    @registered_application.user = current_user
    if @registered_application.save
      flash[:notice] = "Application was registered."
      redirect_to getting_started_path
    else
      flash[:error] = "There was an error registering the application.  Please try again."
      render :new
    end
  end

  def edit
    @registered_application = RegisteredApplication.friendly.find(params[:id])
    authorize @registered_application
  end

  def update
    @registered_application = RegisteredApplication.friendly.find(params[:id])
    authorize @registered_application
    if @registered_application.update_attributes(registered_application_params)
      flash[:notice] = "Application information was updated."
      redirect_to @registered_application
    else
      flash[:error] = "There was an error updating the application.  Please try again."
      render :new
    end
  end

  def index
    @registered_applications = current_user.registered_applications
    redirect_to getting_started_path if @registered_applications.count == 0
  end

  def show
    @registered_application = RegisteredApplication.friendly.find(params[:id])
    authorize @registered_application
    @events = @registered_application.events.group_by(&:name)
    render :show
  end

  def destroy
    @registered_application = RegisteredApplication.friendly.find(params[:id])
    authorize @registered_application
    if @registered_application.destroy
      flash[:notice] = "\"#{@registered_application.name}\" was deleted successfully."
      redirect_to registered_applications_path
    else
      flash[:error] = "There was an error deleting the application.  Please try again."
      redirect_to @registered_application
    end
  end

  private
    def registered_application_params
      params.require(:registered_application).permit(:name, :url, :user)
    end
end

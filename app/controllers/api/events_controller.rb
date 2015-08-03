class API::EventsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_access_control_headers
  

  def create
    @registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
    return render json: "Unregistered application", status: :unprocessable_entity if @registered_application.nil?
    @event = Event.new(event_params)
    @event.registered_application = @registered_application
    if @event.save
      render json: @event, status: :created
    else
      render @event.errors, status: :unprocessable_entity
    end
  end

  private
    def event_params
      params.require(:event).permit(:name)
    end

    def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'Content-Type'
    end



end
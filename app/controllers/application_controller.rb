class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token
  before_action :add_allow_credentials_headers 

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def options                                                                                                                                                                                                                                                                              
    head :status => 200, :'Access-Control-Allow-Headers' => 'accept, content-type'                                                                                                                                                                                                         
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:account_update) << :name
    end

    def user_not_authorized
      flash[:error] = 'You are only allowed to view your own applications.'
      redirect_to(request.referrer || root_path)
    end

    def add_allow_credentials_headers                                                                                                                                                                                                                                                        
      # https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS#section_5                                                                                                                                                                                                      
      #                                                                                                                                                                                                                                                                                       
      # Because we want our front-end to send cookies to allow the API to be authenticated                                                                                                                                                                                                   
      # (using 'withCredentials' in the XMLHttpRequest), we need to add some headers so                                                                                                                                                                                                      
      # the browser will not reject the response                                                                                                                                                                                                                                             
      response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'                                                                                                                                                                                                     
      response.headers['Access-Control-Allow-Credentials'] = 'true'                                                                                                                                                                                                                          
    end 



end

class ApplicationController < ActionController::Base
  # json responses handler
  def json_response(object, status = :ok, location = nil)
    render json: object, status: status, location: location
  end
end

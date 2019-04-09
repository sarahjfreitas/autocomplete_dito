class EventsController < ApplicationController
  def index
  end

  def create
    begin
      evento = Event.create!(name: params[:event], data_hora: params[:timestamps])
      render json: evento
    rescue
    end
  end
 
end

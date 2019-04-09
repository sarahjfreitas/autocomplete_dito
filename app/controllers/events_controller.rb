class EventsController < ApplicationController
  def index
    eventos = Event.order('timestamps DESC')
    json_response(eventos)
  end

  def create
    evento = Event.create!(name: params[:event], timestamps: params[:timestamp])
    json_response(evento, :created, events_url)
  end 
end

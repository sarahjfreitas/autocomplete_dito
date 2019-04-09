class EventsController < ApplicationController
  def index
    if params[:term].present?
      eventos = Event.where("name like '%#{params[:term]}%'").order('timestamps DESC')
    else 
      eventos = Event.order('timestamps DESC')
    end
    json_response(eventos)
  end

  def create
    evento = Event.create!(name: params[:event], timestamps: params[:timestamp])
    json_response(evento, :created, events_url)
  end 

  def list
    retorno = { timeline: [] }
    get_events.each do |ev|
      custom_stuff = { }
      ev.custom_data.each { |cd| custom_stuff[cd.key] = cd.value }

      encontrado = retorno[:timeline].find {|x| x[:transaction_id] == custom_stuff["transaction_id"] }

      if encontrado.blank?
        encontrado = {
          timestamp: nil,
          revenue: nil,
          transaction_id: nil,
          store_name: nil,
          products: [] 
        }
        retorno[:timeline] << encontrado
      end

      encontrado[:transaction_id] = custom_stuff["transaction_id"]
      encontrado[:timestamp] = ev[:timestamp]
      if ev[:revenue].present?
        encontrado[:revenue] = ev[:revenue] 
      end
      if custom_stuff["store_name"].present?
        encontrado["store_name"] = custom_stuff["store_name"]
      end
      if custom_stuff["product_name"].present? and custom_stuff["product_price"].present?
        encontrado[:products] << {
          name: custom_stuff["product_name"],
          price: custom_stuff["product_price"] 
        }
      end
    end
    json_response(retorno)
  end

  private 

  def get_events
    require 'json'
    url = 'https://storage.googleapis.com/dito-questions/events.json'
    response = HTTParty.get(url)
    JSON.parse(response.parsed_response.to_json, object_class: OpenStruct).events
  end

end

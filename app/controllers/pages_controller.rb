class PagesController < ApplicationController
  def teste
    require 'json'
    url = 'https://storage.googleapis.com/dito-questions/events.json'
    response = HTTParty.get(url)
    @teste = JSON.parse(response.parsed_response.to_json, object_class: OpenStruct)
    @retorno = { timeline: [] }
    @find_results = []
    @teste.events.each do |ev|
      
      id = (ev.custom_data.find {|x| x.key == "transaction_id"}).value
      store_name = (ev.custom_data.find {|x| x.key == "store_name"})
      product_name  = (ev.custom_data.find {|x| x.key == "product_name"})
      product_price  = (ev.custom_data.find {|x| x.key == "product_price"})

      timeline_encontrada = @retorno[:timeline].find {|x| x[:transaction_id] == id }
      if timeline_encontrada.blank?
        @retorno[:timeline] << timeline_encontrada = {
          timestamp: nil,
          revenue: nil,
          transaction_id: nil,
          store_name: nil,
          products: []
        }
      end      

      timeline_encontrada[:transaction_id] = id
      timeline_encontrada[:timestamp] = ev[:timestamp]
      timeline_encontrada[:revenue] = ev[:revenue] if ev[:revenue].present?
      timeline_encontrada[:store_name] = store_name.value if store_name.present?
      timeline_encontrada[:products] << {name: product_name.value, price: product_price.value} if (product_name.present? and product_price.present?)
      @find_results << timeline_encontrada
    end
  end
end

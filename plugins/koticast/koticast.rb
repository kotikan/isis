# Returns the current weather forecast for Kotikan HQ

require 'forecast_io'
require 'yaml'

class Koticast < Isis::Plugin::Base 

  def respond_to_message?(message)
    @commands = message.downcase.split
    %w(!koticast !kotikast !willitrain !scanthesky).include? @commands[0]
  end

  def response_html
    forecast = koticast
    %Q(<strong>Weather at Kotikan: </strong>#{forecast[:minutely]} #{forecast[:hourly]} <a href="#{forecast[:url]}">Full report...</a>)
  end

  def response_text
    forecast = koticast
    'Weather at Kotikan:' + forecast[:minutely] + ' ' + forecast[:hourly]
  end

  private

  def koticast
    ForecastIO.api_key = forecast_api_key
    lat, lon = 55.946802, -3.201294
    forecast = ForecastIO.forecast(lat, lon)
    { minutely: forecast.minutely.summary, hourly: forecast.hourly.summary url: %Q(http://forecast.io/#/f/#{lat},#{lon}) }
  end
  
  def forecast_api_key
    config = YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))
    config["api_key"]
  end

end
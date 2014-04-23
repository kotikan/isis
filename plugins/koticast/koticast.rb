# Returns the current weather forecast for Kotikan HQ

require 'forecast_io'

class Koticast < Isis::Plugin::Base 

  def respond_to_message?(message)
    @commands = message.downcase.split
    %w(!koticast !kotikast !willitrain !scanthesky).include? @commands[0]
  end

  def response_html
    forecast = koticast
    %Q(<strong>Weather at Kotikan HQ: </strong>#{forecast[:minutely]} #{forecast[:hourly]})
  end

  def response_text
    forecast = koticast
    'Weather at Kotikan HQ:' + forecast[:minutely] + ' ' + forecast[:hourly]
  end

  private

  def koticast
    ForecastIO.api_key = 'API_KEY'
    forecast = ForecastIO.forecast(55.946802, -3.201294)
    { minutely: forecast.minutely.summary, hourly: forecast.hourly.summary }
  end

end
# Uses api.bunnies.io to provide a random bunny gif

require 'json'
require 'open-uri'

class Bunny < Isis::Plugin::Base

  TRIGGERS = %w(!bunny)

  def respond_to_msg?(msg, speaker)
    TRIGGERS.include? msg.downcase
  end

  private

  def response_text
    response = JSON.load(open('https://api.bunnies.io/v2/loop/random/?media=gif'))
    src = response['media']['gif']

    "#{src}"
  end

end
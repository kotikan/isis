# classicyasir.rb

class Classicyasir < Isis::Plugin::Base

  def respond_to_message?(message)
    if /yasir/i =~ message.content + message.speaker
      true
    else
      false
    end
  end

  def response_text
    'Classic Yasir!'
  end

end
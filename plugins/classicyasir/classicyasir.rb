# classicyasir.rb

class Classicyasir < Isis::Plugin::Base

  RESPONSES = ['Classic Yasir!', 'CLASSIC YASIR', 'Classsssssic Yasir']

  def respond_to_message?(message)
    if /yasir/i =~ message.content + message.speaker
      Random.new().rand(1..10) == 5
    else
      false
    end
  end

  def response_text
    RESPONSES[Random.new().rand(0..(RESPONSES.length - 1))]
  end

end
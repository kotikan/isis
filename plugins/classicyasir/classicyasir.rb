# classicyasir.rb

class Classicyasir < Isis::Plugin::Base

  def respond_to_message?(message)
    @speaker_first_name = speaker_first_name(message)

    Random.new().rand(1..10) == 5
  end

  def response_text
    # I could do this using good OO techniques but it isn't worth it yet
    # for this little delightful plugin. Sorry Uncle Bob!
    response_type = 'response_type_' + Random.new().rand(1..3).to_s
    self.send(response_type, @speaker_first_name)
  end

  private

  def speaker_first_name(message)
    message.speaker.split[0]
  end

  def response_type_1(speaker_first_name)
    "Classic #{speaker_first_name}!"
  end

  def response_type_2(speaker_first_name)
    "CLASSIC #{speaker_first_name.upcase}"
  end

  def response_type_3(speaker_first_name)
    "Classsssssic #{speaker_first_name}"
  end

end
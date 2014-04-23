require 'timecop'
require 'time'
require 'tzinfo'
require_relative '../lib/isis/message'
require_relative '../lib/isis/plugins'

def create_message(content = nil, speaker = nil, room = nil)
  Isis::Message.new(
      {
          :content => content,
          :speaker => speaker,
          :room => room
      }
  )
end

RSpec.configure do |c|
  c.color_enabled = true
  c.formatter = :documentation
end

class MockBot
  attr_reader :timezone

  def initialize
    @timezone = TZInfo::Timezone.get('America/Los_Angeles')
  end
end

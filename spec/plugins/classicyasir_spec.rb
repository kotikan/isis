require 'spec_helper'
require_relative '../../plugins/classicyasir/classicyasir'

describe Classicyasir do

  subject { Classicyasir.new(MockBot.new) }

  context '#respond_to_message?' do

    it "returns false if message content and message speaker do not contain the text 'Yasir'" do
      message = create_message('Content', 'Joe Blogs')
      expect(subject.respond_to_message?(message)).to eq false
    end

    it "returns true if message content contains the text 'Yasir'" do
      message = create_message('Yasir')
      expect(subject.respond_to_message?(message)).to eq true
    end

    it "returns true if message speaker contains the text 'Yasir'" do
      message = create_message('Content', 'Yasir')
      expect(subject.respond_to_message?(message)).to eq true
    end

  end

  context '#response' do

    it "returns the 'Classic Yasir!' phrase" do
      expect(subject.response(['text']).content).to eq 'Classic Yasir!'
    end

  end

end
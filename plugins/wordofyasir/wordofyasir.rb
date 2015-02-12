# wordofyasir.rb
# Returns a random Word of Yasir, or posts a new Word.

require 'twitter'
require 'yaml'

class WordOfYasir < Isis::Plugin::Base 
  
  def setup
    @twitter = load_twitter_client
    @config = load_config
  end

  def respond_to_message?(message)
    @commands = message.content.downcase.split
    @speaker = message.speaker
    %w(!wordofyasir).include? @commands[0]
  end

  def response_text
    if @commands[1].nil?
      return random_word
    elsif @commands[1].downcase == 'help'
      return %Q{Usage:\n    !wordofyasir --- print a random Word.\n    !wordofyasir "The latest Word" --- tweet the latest Word, if you're authorised.}
    else
      return tweet(@commands[1])
    end
  end

  private

  def random_word
    begin
      tweets = @twitter.user_timeline("wordofyasir", {count: 200})
      return tweets[Random.rand(tweets.count)].uri.to_s
    rescue
      return "Something went wrong, I might be misconfigured or twitter could be having problems."
    end
  end
  
  def tweet(body)
    if speaker_entitled_to_tweet
      return check_and_send_tweet(body)
    else
      return "I'm sorry " + @speaker.split[0] + ", I'm afraid I can't do that." 
    end
  end
  
  def speaker_entitled_to_tweet
    for part in @speaker.downcase.split do
      if @config['whitelist_users'].include? part
        return true
      end
    end
    return false
  end
  
  def check_and_send_tweet(body)
    if tweet_body.length <= 140
      return send_tweet(body) 
    else
      return body.length.to_s + " characters? tl;dr"
    end
  end
  
  def send_tweet(body)
    begin
      return @twitter.update(body).uri.to_s
    rescue
      return "Something went wrong, I might be misconfigured or twitter could be having problems."
    end
  end
  
  def load_twitter_client
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = @config['consumer_key']
      config.consumer_secret     = @config['consumer_secret']
      config.access_token        = @config['access_token']
      config.access_token_secret = @config['access_secret']
    end
  end
  
  def load_config
    YAML.load_file(File.join(File.dirname(__FILE__), 'config.yml'))
  end

end
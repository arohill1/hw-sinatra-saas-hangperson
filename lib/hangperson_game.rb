class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  
  LOSE = 7
  
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @message = ''
    
  end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def guess(letter)
    raise ArgumentError if  letter.nil? || letter.empty? || letter.match(/[^a-zA-Z]/)
    letter.downcase!
    return false if 
      (guesses.include? letter) || (wrong_guesses.include? letter)
    if word.include? letter
      guesses << letter
    else
      wrong_guesses << letter
    end
    return true
  end
  
  def check_win_or_lose
    return :lose if wrong_guesses.length >= LOSE
    word_with_guesses == word ? :win : :play 
  end
  
  def word_with_guesses
    word.gsub(/./) do |letter|
      (guesses.include? letter)? letter : "-"
    end
  end
    
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
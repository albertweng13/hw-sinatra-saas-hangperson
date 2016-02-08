class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
  
  def guess(ltr)
    #check if valid letter
    if not ltr =~ /[a-z]/i
      raise ArgumentError
    end
    
    change = false
    ltr.downcase!
    
    if self.word.include? ltr
      if not self.guesses.include? ltr
        self.guesses += ltr
        change = true
      end
    else
      if not self.wrong_guesses.include? ltr
        self.wrong_guesses += ltr
        change = true
      end
    end
    return change
  end
  
  def word_with_guesses
    new_word = self.word.dup
    self.word.split('').each do |ltr|
      if not self.guesses.include? ltr
        new_word.gsub!(ltr, '-')
      end
    end
    return new_word
  end
  
  def check_win_or_lose
    if self.word == word_with_guesses
      return :win
    elsif self.wrong_guesses.length > 6
      return :lose
    end
    return :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end

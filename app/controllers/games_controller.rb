require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
    session[:total] ||= 0
  end

  def score
    @word = params[:word].upcase
    letter_arr = params[:letters].upcase.split(' ')
    word_arr = @word.chars
    @game_hash = check_real(@word)
    @message = generate_message(word_arr, letter_arr)
  end

  def build_possible?(word_arr, letter_arr)
    if word_arr.all? { |letter| word_arr.count(letter) <= letter_arr.count(letter) }
      true
    else
      false
    end
  end

  def generate_message(word_arr, letter_arr)
    if build_possible?(word_arr, letter_arr)
      case @game_hash['found']
      when true
        session[:total] += score_game(@word)
        "You win! #{@word} is a valid word! Score: #{score_game(@word)}"
      else @word.length.zero? ? 'You did not give any word' : "Sorry #{@word} this is not a valid English word"
      end
    else
      "Sorry, you can't build #{@word} from #{letter_arr.join(', ')}!"
    end
  end

  def score_game(word)
    length = word.length
    if length <= 3
      5
    elsif length > 3 && length < 5
      (5 + (length * 2))
    else
      (10 + (length * 3))
    end
  end

  def check_real(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized = URI.open(url).read
    JSON.parse(serialized)
  end
end

require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    8.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    @letters = params[:letters]
    word = params[:word]
    word_chars = word.split('')
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    result_hash = JSON.parse(open(url).read)

    cheat_tester = word_chars.all? do |letter|
      @letters.split('').count(letter) >= word_chars.count(letter)
    end

    if cheat_tester == false
      @result = "You're trying to cheat dickhead!"
    elsif result_hash['found'] == false
      @result = "#{word} does not exist"
    else
      points = result_hash['length'] * result_hash['length']
      @result = "You've earned #{points} with #{word}"
    end
  end
end

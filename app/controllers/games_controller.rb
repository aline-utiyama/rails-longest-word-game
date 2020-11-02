require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    letters_split = params[:letters].split.sort
    word_split = params[:word].split("").sort
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    file = open(url).read
    validation = JSON.parse(file)

    # word_split.all? do |letter|

    # end

    if letters_split & word_split == word_split && validation["found"] == true
      @response = "Congratulations! #{params[:word]} is a valid English word!"
    elsif letters_split & word_split == word_split && validation["found"] == false
      @response = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    else
      @response = "Sorry but #{params[:word].upcase} can't be built out of [#{params[:letters].upcase}]"
    end
  end
end

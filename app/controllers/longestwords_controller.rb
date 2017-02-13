require 'tasks/longest_word.rb'

class LongestwordsController < ApplicationController
  def game
    @start_time = Time.now
    @grid = generate_grid(9)
  end

  def score
    @try = params[:try]
    @grid = params[:grid].split('')
    @start_time = params[:start_time].to_datetime
    @end_time = Time.now
    @result = run_game(@try, @grid, @start_time, @end_time)
  end
end

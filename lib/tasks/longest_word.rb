require 'open-uri'
require 'json'

def generate_grid(grid_size)
  # TODO: generate random grid of letters
  (0...grid_size).map { ('A'..'Z').to_a[rand(26)] }
end

def run_game(attempt, grid, start_time, end_time)
  score = attempt.size.to_f / (end_time - start_time).to_f
  if verify_attempt(attempt, grid) == true
    message = "well done"
  else
    message = "not in the grid"
    score = 0
  end
  message = "not an english word" if translate(attempt).nil? && message != "not in the grid"
  score = 0 if translate(attempt).nil?
  return { score: score, time: (end_time - start_time), translation: translate(attempt), message: message }
end

def translate(attempt)
  url_a = "https://api-platform.systran.net/translation/text/translate?source="
  url = url_a + "en&target=fr&key=52332669-6ba7-485b-b298-a8f2be904660&input=" + attempt.to_s
  attempt_serialized = open(url).read
  translation = JSON.parse(attempt_serialized)
  if translation["outputs"][0]["output"] != attempt
    return translation["outputs"][0]["output"]
  end
end


def verify_attempt(attempt, grid)
  letters = attempt.upcase.chars
  letters.all? do |letter|
    grid.delete_at(grid.find_index(letter)) if grid.include?(letter)
  end
end

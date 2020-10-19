class Recipe
  require 'time'
  attr_reader :name, :description, :rating, :prep_time, :done_status

  def initialize(name, description, rating = 0, prep_time = "", done_status = false)
    @name = name
    @description = description
    @rating = rating
    @prep_time = prep_time
    @done_status = done_status == "true"
  end

  def mark_as_done
    @done_status = true
  end
end

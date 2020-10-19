class Cookbook
  require 'csv'
  require_relative 'recipe'

  def initialize(csv_file_path)
    @file_path = csv_file_path
    @recipes = []
    CSV.foreach(@file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    save_in_csv
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    save_in_csv
  end

  def search_recipe(index)
    @recipes[index]
  end

  def mark_as_done
    save_in_csv
  end

  private

  def save_in_csv
    @csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@file_path, 'wb', @csv_options) do |csv|
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.prep_time, recipe.done_status]
      end
    end
  end
end

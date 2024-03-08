class Ingredient < ApplicationRecord
  belongs_to :recipe
  validates :title, presence: true
  after_commit :set_recipe_content

  private

  def set_recipe_content
    service = OpenaiService.new(self.recipe)
    self.recipe.update(content: service.generate_content)
  end

end

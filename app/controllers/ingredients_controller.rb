class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[ destroy ]

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.recipe = @recipe
    if @ingredient.save
      redirect_to @recipe
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient = Ingredient.find(params[:id])
    @recipe = @ingredient.recipe
    @ingredient.destroy
    redirect_to @recipe, notice: "Ingredient was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.require(:ingredient).permit(:title)
    end
end

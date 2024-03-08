Ingredient.destroy_all
Recipe.destroy_all

Recipe.create(name: "Guacamole")
Ingredient.create([
  {recipe: Recipe.first, title: "avocado"} ,
  {recipe: Recipe.first, title: "cilantro"},
  {recipe: Recipe.first, title: "lime"}])

Recipe.create(name: "Ratatouille")
Ingredient.create([
  {recipe: Recipe.last, title: "eggplant"}, 
  {recipe: Recipe.last, title: "zucchini"},
  {recipe: Recipe.last, title: "bell pepper"}])
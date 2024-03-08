require "open-uri"

class OpenaiService
  def initialize(recipe)
    @recipe = recipe
    @client = OpenAI::Client.new
  end

  def generate_content
    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo", 
        messages: [{ role: "user", content: "Give me a simple recipe for #{@recipe.name} with the ingredients #{@recipe.ingredients.map(&:title).join(", ")}. Give me only the text of the recipe, without any of your own answer like 'Here is a simple recipe'."}],
        temperature: 0.7,
      })
    response.dig("choices", 0, "message", "content")
  end

  def generate_photo
    response = @client.images.generate(parameters: {
      prompt: "A recipe image of #{@recipe.name}", size: "256x256"
    })

    url = response.dig("data", 0, "url")
    URI.open(url)
  end
end
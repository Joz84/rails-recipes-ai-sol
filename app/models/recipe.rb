class Recipe < ApplicationRecord
  has_many :ingredients
  has_one_attached :photo
  validates :name, presence: true
  after_save :set_photo
  # after_save :set_recipe_content

  private

  def set_recipe_content
    service = OpenaiService.new(self)
    self.update(content: service.generate_content)
  end

  def set_photo
    service = OpenaiService.new(self)
    file = service.generate_photo
    photo.purge if photo.attached?
    photo.attach(io: file, filename: "ai_generated_image.jpg", content_type: "image/png")
    return photo
  end

end

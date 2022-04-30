class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, uniqueness: true

  before_save :set_slug

  def to_param
    self.slug
  end

  def set_slug
    base_slug = self.title.parameterize(separator: "_")
    counter = 1
    current_slug = base_slug
    while self.class.find_by(slug: current_slug)
      current_slug = "#{base_slug}_#{counter.to_s}"
      counter += 1
    end
    self.slug = current_slug
  end
end

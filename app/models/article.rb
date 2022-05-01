class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :slug, uniqueness: true

  before_save :set_slug

  def to_param
    self.slug || self.id
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

  class << self
    # Where "arg" could be either a string slug or an integer ID
    def find_by_slug_or_id(arg)
      if arg.to_i > 0
        @article = Article.find(arg)
      else
        @article = Article.where(slug: arg).first
      end
    end

  end
end

class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :author, class_name: "Person"

  before_save :set_slug, :if => Proc.new{ self.title_changed? }

  def to_param
    "#{self.id}-#{self.slug}"
  end

  def set_slug
    self.slug = self.title.parameterize(separator: "-")
  end

end

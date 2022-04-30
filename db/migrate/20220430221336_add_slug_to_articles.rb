class AddSlugToArticles < ActiveRecord::Migration[7.0]
  def up
    add_column :articles, :slug, :string
  end

  def down
    remove_column :articles, :slug
  end
end

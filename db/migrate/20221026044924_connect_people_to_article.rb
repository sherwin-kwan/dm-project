class ConnectPeopleToArticle < ActiveRecord::Migration[7.0]
  def up
    add_reference :articles, :author, index: true, foreign_key: {to_table: :people}
    change_table :people do |t|
      t.change :name, :string, required: false
    end
  end

  def down
    change_table :people do |t|
      t.change :name, :string, required: true
    end
  end
end

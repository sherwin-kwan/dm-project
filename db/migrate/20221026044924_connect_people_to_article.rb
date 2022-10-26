class ConnectPeopleToArticle < ActiveRecord::Migration[7.0]
  def change
    add_reference :articles, :author, index: true, foreign_key: {to_table: :people}
    change_table :people do |t|
      t.change :name, :string, required: false
    end
  end
end

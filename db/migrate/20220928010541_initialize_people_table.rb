class InitializePeopleTable < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :name, :string, required: true
    add_column :people, :given_name, :string
    add_column :people, :display_name, :string
    add_column :people, :bio, :text
    add_column :people, :slogan, :string
    add_column :people, :fb_name, :string
    add_column :people, :ig_name, :string
    add_column :people, :tw_name, :string
    add_column :people, :li_name, :string
    add_column :people, :country, :string
    add_column :people, :city, :string
    add_column :people, :gender, :string
    add_column :people, :date_of_birth, :date
    add_reference :people, :user, foreign_key: true, index: true
  end
end

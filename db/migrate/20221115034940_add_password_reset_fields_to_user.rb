class AddPasswordResetFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :reset_token_digest, :string
    add_column :users, :reset_token_expiry_time, :datetime
  end
end

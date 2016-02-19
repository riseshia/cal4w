class AddTokenInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :token_valid_until, :datetime
  end
end

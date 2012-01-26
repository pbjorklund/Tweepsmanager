class CreateAuths < ActiveRecord::Migration
  def change
    create_table :auths do |t|
      t.string :provider
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end

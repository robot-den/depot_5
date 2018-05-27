class AddLanguageIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :language_id, :integer
  end
end

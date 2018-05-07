class ReplacePayTypeWithPayTypeIdInOrdersTable < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :pay_type, :pay_type_id
  end
end

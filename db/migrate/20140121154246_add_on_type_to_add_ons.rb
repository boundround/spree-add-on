class AddOnTypeToAddOns < ActiveRecord::Migration
  def change
    add_column :spree_add_ons, :add_on_type, :string
  end
end

class AddEmbroideryFieldsToAddOn < ActiveRecord::Migration
  def change
  	add_column :line_item_add_on, :embroidery_text, :string
  	add_column :line_item_add_on, :embroidery_font, :string
  	add_column :line_item_add_on, :embroidery_color, :string
  	add_column :add_on, :show_embroidery, :boolean, :default => false
  	add_column :add_on, :embroidery_options, :string

  end
end

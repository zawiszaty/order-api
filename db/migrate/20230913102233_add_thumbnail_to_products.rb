class AddThumbnailToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :thumbnail_url, :string
  end
end

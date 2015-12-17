class MakeItemDoneFalseDefault < ActiveRecord::Migration
  def change
    change_column :items, :done, :boolean, default: false
  end
end

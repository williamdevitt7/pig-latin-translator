class CreateTranslations < ActiveRecord::Migration[7.0]
  def change
    create_table :translations do |t|
      t.string :language
      t.text :input
      t.text :translation

      t.timestamps
    end
  end
end

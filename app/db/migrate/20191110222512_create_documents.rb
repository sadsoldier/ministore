class CreateDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :documents do |t|
      t.string :app_id
      t.string :document_id
      t.timestamps
    end
  end
end


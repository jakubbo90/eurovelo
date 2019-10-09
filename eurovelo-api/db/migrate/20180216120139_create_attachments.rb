class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.references :attachmentable, polymorphic: true, index: true
      t.attachment :source

      t.timestamps
    end
  end
end

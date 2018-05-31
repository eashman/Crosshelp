class AddAttachmentToApplicant < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :attachment, :string
  end
end

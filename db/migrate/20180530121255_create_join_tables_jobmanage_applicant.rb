class CreateJoinTablesJobmanageApplicant < ActiveRecord::Migration[5.2]
  def change
    create_join_table :jobmanages, :applicants do |t|
       t.index [:jobmanage_id, :applicant_id]
       t.index [:applicant_id, :jobmanage_id]
    end
  end
end

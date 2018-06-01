Trestle.resource(:applicants) do
  menu do
    item :applicants, icon: "fa fa-file-text-o", label: '简历',group: '求职'
  end
  remove_action :new

  # Customize the table columns shown on the index view.
  #
   table do
     column :user_id,->(sp) { sp.user.name }, link: false
     column :name
     column :sex
     column :head, ->(applicant) { image_tag(applicant.head) if applicant.nil? }
     column :begin_work_date
     column :birthday
     column :phone
     column :job_status
     column :created_at, align: :center
   end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |applicant|
  #   text_field :name
  #
  #   row do
  #     col(xs: 6) { datetime_field :updated_at }
  #     col(xs: 6) { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:applicant).permit(:name, ...)
  # end
end

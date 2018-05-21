Trestle.resource(:administrators, model: Trestle.config.auth.user_class, scope: Auth) do
  menu do
    group :configuration, priority: :last do
      item :administrators, icon: "fa fa-users",label: '管理员'
    end
  end

  table do
    column :avatar, header: false do |administrator|
      avatar_for(administrator)
    end
    column :email, link: true
    actions do |a|
      a.delete unless a.instance == current_user
    end
  end

  form do |administrator|
    text_field :email

    row do
      col(sm: 6) { password_field :password }
      col(sm: 6) { password_field :password_confirmation }
    end
  end
end

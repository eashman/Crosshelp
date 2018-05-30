# frozen_string_literal: true

Trestle.resource(:articles) do
  routes do
    post :hidden
  end
  menu do
    item :articles, icon: 'fa fa-star', label: '资讯'
  end

  search do |query|
    if query
      Article.where("title ILIKE ?", "%#{query}%")
    else
      Article.all
    end
   end

  controller do
    def hidden
      p_id = params[:articles_admin_id]
      article = Article.find_by(id: p_id )
      if article.hidden
        article.update(hidden: false)
      else
        article.update(hidden: true)
      end
      flash[:message] = flash_message("ok", title: "success!")
      redirect_to action: :index
    end
  end

  controller do
    def show
     super
     instance = self.instance
     render 'show'
    end
  end
  # Define the index view table listing
  table do
    column :title, header: '标题'
    column :author, header: '作者'
    column :hidden, header: '显示状态', align: :center do |article|
      if article.hidden
        status_tag(icon('fa fa-check'), :info)
      else
        status_tag(icon('fa fa-check-o'), :info)
     end
    end
    column :updated_at, header: '更新时间', align: :center
    actions do |a|
      a.button icon("fa fa-check"), articles_admin_hidden_path(a.instance),method: :post,class: "btn btn-primary"
      a.show
      a.edit
      a.delete
    end
  end
  form do
    # Organize fields into tabs and sidebars
    tab :post do
      text_field :title, label: '标题'
      text_field :author, label: '作者'
      # Define custom form fields for easy re-use
      editor :body, label: '内容'
    end
  end
end

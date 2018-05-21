Trestle.resource(:articles) do
  menu do
    item :articles, icon: "fa fa-star",label: "资讯"
  end

  # Define the index view table listing
 table do
   column :title, link: true,header: "标题"
   column :author,header: "作者"
   column :hidden, header: "显示状态",align: :center do |article|
     if article.hidden
       status_tag(icon("fa fa-square"), :default)
     else
       status_tag(icon("fa fa-square-o"), :default)
    end
   end
   column :updated_at, header: "更新时间", align: :center
   actions
 end
 form do
    # Organize fields into tabs and sidebars
    tab :post do
      text_field :title,label: "标题"
      text_field :author,label: "作者"
      # Define custom form fields for easy re-use
      editor :body,label: "内容"
    end
  end
end

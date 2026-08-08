module ApplicationHelper
  include Pagy::Method

  def nav_link_class(path)
    if current_page?(path)
      "bg-blue-900 text-white rounded-md px-3 py-2 text-sm font-bold shadow-inner"
    else
      "text-blue-100 hover:bg-blue-700 hover:text-white rounded-md px-3 py-2 text-sm font-medium transition-colors"
    end
  end
end

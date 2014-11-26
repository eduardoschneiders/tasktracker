module ApplicationHelper
  def active_menu(path)
   'active' if request.fullpath == path
  end
end

module TasksHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def sortable_task_users(column, title = nil)
    title ||= column.titleize
    css_class = column == task_users_column ? "current #{sort_direction}" : nil
    direction = column == task_users_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def sortable_name_users(column, title = nil)
    title ||= column.titleize
    css_class = column == task_users_column ? "current #{sort_direction_for_users}" : nil
    direction_users = sort_direction_for_users == "asc" ? "desc" : "asc"
    link_to title, { :direction_users => direction_users}, {:class => css_class}
  end
end

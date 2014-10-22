module ApplicationHelper

  def full_title(page_title)
    base_title = "Todo"
    if page_title.empty?
      "Todo App"
    else
      "#{base_title} | #{page_title}"
    end
  end
end

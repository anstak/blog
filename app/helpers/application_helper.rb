module ApplicationHelper
  def full_title(page_title)
    "#{page_title} |" unless page_title.empty?
  end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def label_for_status(status)
    case status
      when 1 then return "Viewer"
      when 2 then return "Member"
      when 3 then return "Subscriber"
      when 4 then return "Publisher"
      when 5 then return "Editor"
    end
  end
end

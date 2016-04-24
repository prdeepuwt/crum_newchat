module ApplicationHelper
  def process_tags(text)
    sanitized_text = ActionController::Base.helpers.sanitize text
    tags = Array.new
    sanitized_text.split(/,/).each do |text|
      tag = text.strip.gsub(' ','_')
      if tag.length > 0 and !tag.nil?
        tags << tag.downcase
      end
    end
    tags
  end
end

module ApplicationHelper

  def sanitized_object_name(object_name)
    object_name.gsub(/\]\[|[^-a-zA-Z0-9:.]/, "_").sub(/_$/, "")
  end
    
  def sanitized_method_name(method_name)
    method_name.sub(/\?$/,"")
  end
    
  def form_tag_id(object_name, method_name)
    "#{sanitized_object_name(object_name.to_s)}_#{sanitized_method_name(method_name.to_s)}"
  end
  
  def program_select_name(program)
    year = program.year.blank? ? '' : " (#{program.year})"
    version = program.version.blank? ? '' : " - #{program.version}"
    "#{program.name}#{year}#{version}"
  end

  def show_icon
    icon('file-earmark-font')
  end

  def edit_icon
    icon('pencil-fill')
  end

  def destroy_icon
    icon('trash-fill')
  end

  private

  def icon(icon, options = {})
    file = File.read("#{Rails.root}/node_modules/bootstrap-icons/icons/#{icon}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css 'svg'
    if options[:class].present?
      svg['class'] += " " + options[:class]
    end
      doc.to_html.html_safe
  end

end

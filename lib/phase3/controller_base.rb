require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      snake_class = self.class.to_s.underscore
      path = "views/#{snake_class}/#{template_name.to_s}.html.erb"
      read_file = File.read(path, :encoding => 'iso-8859-1')
      content = ERB.new(read_file).result(binding)
      content_type = "text/html"
      render_content(content, content_type)
    end
  end
end

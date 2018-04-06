module ApplicationHelper
  def hidden_div_if(condition, attrs = {}, &block)
    attrs['style'] = 'display: none' if condition
    content_tag('div', attrs, &block)
  end
end

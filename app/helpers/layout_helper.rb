module LayoutHelper

  def page_header(title)
    content_tag 'div', class: 'page-header' do
      html = content_tag 'div', title, class: 'page-header--title'
      html << content_tag('div', yield, class: 'page-header--actions') if block_given?
      html
    end
  end

end
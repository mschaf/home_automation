module MaterializeHelper

  def icon(name)
    content_tag :i, name, class: 'material-icons'
  end

end
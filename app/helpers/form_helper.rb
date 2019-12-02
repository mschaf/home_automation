module FormHelper

  def string_input(form, attribute)
    object = form.object
    has_error = form.object.errors.key?(attribute)
    form_group_class = 'form-group'
    form_group_class << ' -with-errors' if has_error
    content_tag :div, class: form_group_class do
      html = form.label attribute, class: 'form-group--label'
      if has_error
        html << content_tag(:ul, class: 'form-group--errors') do
          form.object.errors[attribute].map { |error| content_tag :li, error, class: 'form-group--error' }.join.html_safe
        end
      end
      html << form.text_field(attribute, class: 'form-group--text-field')
      html
    end

  end

  def submit_button(form)
    form.submit form.object.persisted? ? "Update" : "Save", class: 'button -success'
  end


end
When /^the "(.+)" field should have an error$/ do |field|
  field = find_field(field)
  form_group = field.find(:xpath, '..')
  expect(form_group[:class]).to include('-with-errors')
end

When /^the "(.+)" field should the error "(.+)"$/ do |field, error|
  field = find_field(field)
  error_list = field.find(:xpath, '../ul[@class="form-group--errors"]')
  expect(error_list.text).to include error
end
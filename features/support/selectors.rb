module HtmlSelectorsHelpers
  # Maps a name to a selector. Used primarily by the
  #
  #   When /^(.+) within (.+)$/ do |step, scope|
  #
  # step definitions in web_steps.feature
  #
  def selector_for(locator)
    case locator

    when "the page"
      "html > body"

    when /^the (.+?)(?:'s (.+?)(?: that (.+))?)?$/
      selector = '.'
      selector << selectorify($1)
      selector << '--' << selectorify($2) if $2
      selector << '.' << selectorify($3) if $3
      selector


    when /^"(.+)"$/
      $1

    else
      raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
                "Now, go and add a mapping in #{__FILE__}"
    end
  end

  private

  def selectorify(string)
    string.gsub(/ /, '-')
  end

end

World(HtmlSelectorsHelpers)

module StateIndicatorHelper


  def online_indicator(last_seen)
    content_tag(:div,
                content_tag(:div,
                            (last_seen ? " (last seen #{distance_of_time_in_words(last_seen, Time.now)} ago)" : ''),
                            class: 'online-indicator--state'),
                class: "online-indicator #{(last_seen && last_seen > 30.minutes.ago ? '-online' : '-offline')}")
  end

  def switch_state_indicator(state)
    if state
      content_tag(:span, 'on', class: 'badge badge-success')
    else
      content_tag(:span, 'off', class: 'badge badge-danger')
    end
  end
end

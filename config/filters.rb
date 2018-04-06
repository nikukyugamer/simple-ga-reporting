module Filters
  def my_awesome_filter
  end

  def his_awesome_filter
  end

  def her_awesome_filter
  end

  def chrome_or_fx
    filter :chrome_or_fx, &lambda { contains(:browser, 'Chrome|Firefox') }
    # filter :chrome_or_fx, &lambda { ['Chrome', 'Firefox'].map { |browser| matches(:browser, browser) } }
  end

  def over_one_thousand_search_sessions
    filter :over_one_thousand_search_sessions, &lambda { gte(:searchSessions, 1000) }
  end
end

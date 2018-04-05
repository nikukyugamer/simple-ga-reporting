module Filters
  def chrome_or_fx
    filter :chrome_or_fx, &lambda { ['Chrome', 'Firefox'].map {|browser| matches(:browser, browser)} }
    # filter :chrome_or_fx, &lambda { contains(:browser, 'Chrome|Firefox') }
  end

  def over_one_thousand_search_sessions
    filter :over_one_thousand_search_sessions, &lambda { gte(:searchSessions, 1000) }
  end
end
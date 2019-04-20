require 'mechanize'

class ScrapingAgent
  def initialize
    @agent = Mechanize.new
    @agent.history_added = Proc.new { sleep 2 }
    @agent.user_agent_alias = "Mac Safari"
  end

  def url_not_valid?(url)
    url_str = url || ""
    regex = /https\:\/\/www\.linkedin\.com(?<path>\/in\/.*)/

    match = url_str.match(regex)
    #err_msg = "Invalid URL. Required format: https://www.linkedin.com/in/:username"

    match.nil? || match[:path].nil?
  end

  def scrape(url)
    return nil if url_not_valid?(url)

    data_selectors = {
      :fullname => "#name",
      :title => ".profile-section .profile-overview-content .headline",
      :position => "#experience > .positions > .position:first-child .item-title",
      :company => ".item-subtitle"
    }

    @profile_page = @agent.get(url)
    profile_data = {url: url}
    data_selectors.each do |attr, selector|
      profile_data[attr] = @profile_page.at_css(selector).text if @profile_page.at_css(selector)
    end

    profile_data[:skills] = @profile_page.css(".skill").map{ |o| o.text.downcase }.sort if @profile_page.css(".skill")

    profile_data
  end

end

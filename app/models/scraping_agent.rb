require 'mechanize'
require 'pry-byebug'

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

    @profile_page = @agent.get(url)
    profile_data = {}

    profile_data[:fullname] = @profile_page.at_css('#name')
    profile_data[:title] = @profile_page.at_css(".profile-section .profile-overview-content .headline")
    profile_data[:position] = @profile_page.at_css("#experience > .positions > .position:first-child .item-title")
    profile_data[:company] = @profile_page.at_css(".item-subtitle")

    profile_data.keys.each do |key|
      if profile_data[key]
        profile_data[key] = profile_data[key].text
      else
        profile_data.delete(key)
      end
    end

    profile_data[:skills] = @profile_page.css(".skill")
    profile_data[:skills] = profile_data[:skills].map{ |o| o.text.downcase }.sort if profile_data[:skills]
    profile_data[:url] = url

    profile_data
  end

end

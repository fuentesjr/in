class ProfileScrapingJob < ApplicationJob
  queue_as :default

  def perform(url)
    agent = ScrapingAgent.new
    profile_data = agent.scrape(url)

    if profile_data.nil?
      Rails.logger.error "Failed to scrape page=#{url} Verify it's a valid page."
      return
    end

    new_profile = Profile.create!(profile_data.except(:skills))
    new_profile.skills.build(profile_data[:skills].map{|skill| { name: skill} })
    new_profile.save!
    Rails.logger.info "Profile=#{new_profile.inspect}"
  end
end

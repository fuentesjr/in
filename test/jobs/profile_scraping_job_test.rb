require 'test_helper'

class ProfileScrapingJobTest < ActiveJob::TestCase
  test "profile scraping job scrapes and saves data to db" do
    url = "https://www.linkedin.com/in/jeff-dean-8b212555"
    assert_difference('Profile.count') do
      VCR.use_cassette("fetch_jeff_deans_linkedin_profile") do
        ProfileScrapingJob.perform_now(url)
      end
    end
  end
end

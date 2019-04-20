require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "GET index endpoint" do
    get profiles_url
    assert_response :success
  end

  test "GET search based on fullname attr" do
    demis = profiles(:demis)
    search_params = { query: demis.fullname, search_field: "fullname" }
    search_url = "#{search_profiles_url}?#{search_params.to_query}"
    get search_url, as: :json

    assert_response :success
    assert_equal(demis.id,
                 response.parsed_body["results"]["profiles"].first["id"])
  end


  test "GET search based on skills attr" do
    demis = profiles(:demis)
    search_params = { query: "algorithms", search_field: "skills" }
    search_url = "#{search_profiles_url}?#{search_params.to_query}"
    get search_url, as: :json

    assert_response :success
    assert_equal(2, response.parsed_body["results"].count)
  end


  test "POST create scraping job" do
    assert_difference('Profile.count') do
      params = { url: "https://www.linkedin.com/in/jeff-dean-8b212555" }

      VCR.use_cassette("fetch_jeff_deans_linkedin_profile") do
        post profiles_url, params: params, as: :json
      end
    end

    assert_equal({ "status" => "scrape request addded to job queue"},  response.parsed_body)
  end
end

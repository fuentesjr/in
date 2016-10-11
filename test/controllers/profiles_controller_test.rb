require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "GET index endpoint" do
    get profiles_url
    assert_response :success
  end

  test "GET search endpoint" do
    demis = profiles(:demis)
    search_params = { query: demis.fullname, search_field: "fullname" }
    search_url = "#{search_profiles_url}?#{search_params.to_query}"
    get search_url, as: :json

    assert_response :success
    assert_equal(demis.id, response.parsed_body["results"].first["id"])
  end

  test "POST create endpoint" do
    assert_difference('Profile.count') do
      profile = { profile: { fullname: 'Bobby Tables'} }
      post profiles_url, params: profile, as: :json
    end

    assert_equal({ "status" => "created"},  response.parsed_body)
  end
end

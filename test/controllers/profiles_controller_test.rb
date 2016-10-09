require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  test "GET index endpoint" do
    get profiles_url
    assert_response :success
  end

  test "GET search endpoint" do
    get search_profiles_url
    assert_response :success
  end

  test "POST create endpoint" do
    assert_difference('Profile.count') do
      profile = { profile: { fullname: 'Bobby Tables'} }
      post profiles_url, params: profile
    end
  end
end

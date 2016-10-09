require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
   test "saving without fullname" do
     profile = Profile.new
     assert_not profile.save
   end
end

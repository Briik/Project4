require 'test_helper'

class AgencyTest < ActiveSupport::TestCase
    test 'test for Agencies exists' do
        assert true
    end

    test 'agency names are unique' do
        navy = Agency.find_by(name: "agency1")
        assert_raises(ActiveRecord::RecordInvalid){ Agency.new({name: "agency1"}).save! }
    end
end

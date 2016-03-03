require 'test_helper'

class ContractTest < ActiveSupport::TestCase
    contract = Contract.find_by(title: "contract99")

    test "test for Contracts exists" do
    assert true
    end

    test "a hundred contracts exist" do
        assert_equal Contract.count, 100
    end

    test "contracts have titles" do
        refute_nil Contract.find_by(title: "contract1")
    end

    test "contract has an agency_id" do
        assert_kind_of Numeric, contract.agency_id
        refute_instance_of String, contract.agency_id
    end

    test "contract test loads agencies" do
        refute_nil Agency.all
        assert_equal Agency.count, 100
    end

    test "contract dollar is a BigDecimal" do
        assert contract.dollar_amt.class, BigDecimal
    end

    test "contract instance methods work" do
        assert contract.percent_val, BigDecimal
        assert contract.percent_of_agency, BigDecimal
    end
end

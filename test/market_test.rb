require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor_1 = Vendor.new("Rocky Mountain Fresh")
    @vendor_1.stock("Peaches", 35)
    @vendor_1.stock("Tomatoes", 7)
    @vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor_2.stock("Banana Nice Cream", 50)
    @vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    @vendor_3 = Vendor.new("Palisade Peach Shack")
    @vendor_3.stock("Peaches", 65)
  end

  def test_market_exists
    assert_instance_of Market, @market
  end

  def test_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
  end

  def test_add_vendor
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_2, @vendor_3], @market.vendors
  end

  def test_market_vendor_names
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"], @market.vendor_names
  end

  def test_vendors_that_sell
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    assert_equal [@vendor_1, @vendor_3], @market.vendors_that_sell("Peaches")
    assert_equal [@vendor_2], @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_sorted_item_list
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected = [
      "Banana Nice Cream",
      "Peach-Raspberry Nice Cream",
      "Peaches",
      "Tomatoes"
    ]

    assert_equal expected, @market.sorted_item_list
  end

  def test_total_inventory
    @market.add_vendor(@vendor_1)
    @market.add_vendor(@vendor_2)
    @market.add_vendor(@vendor_3)

    expected = {
      "Peaches"=>100,
      "Tomatoes"=>7,
      "Banana Nice Cream"=>50,
      "Peach-Raspberry Nice Cream"=>25
    }
    assert_equal expected, @market.total_inventory
  end

  def test_sell
    refute @market.sell("Peaches", 200)
    refute @market.sell("Onions", 1)
    assert @market.sell("Banana Nice Cream", 5)
  end
end

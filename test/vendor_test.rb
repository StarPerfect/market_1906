require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/vendor'

class VendorTest < Minitest::Test
  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_vendor_exists
    assert_instance_of Vendor, @vendor
  end

  def test_attributes
    assert_equal 'Rocky Mountain Fresh', @vendor.name
    assert_equal ({}), @vendor.inventory
  end

  def test_stocking
    assert_equal 0, @vendor.check_stock("Peaches")

    @vendor.stock('Peaches', 30)

    assert_equal 30, @vendor.check_stock("Peaches")

    @vendor.stock('Peaches', 25)

    assert_equal 55, @vendor.check_stock("Peaches")

    @vendor.stock("Tomatoes", 12)

    assert_equal ({"Peaches"=>55, "Tomatoes"=>12}), @vendor.inventory
  end
end

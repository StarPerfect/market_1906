class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map{ |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all{ |vendor| vendor.inventory.keys.include? item }
  end

  def sorted_item_list
    all_items = []
    @vendors.each do |vendor|
      all_items << vendor.inventory.keys
    end
    all_items.sort_by{ |item| item }
    .flatten
    .uniq
  end

  def total_inventory
    master_inventory = Hash.new(0)
    sorted_item_list.each do |item|
      @vendors.each do |vendor|
        master_inventory[item] += vendor.inventory[item]
      end
    end
    master_inventory
  end

  def sell(item, desired_amount)
    if total_inventory.keys.include?(item) && total_inventory[item] > desired_amount
      unless desired_amount == 0
        @vendors.each do |vendor|
          if vendor.inventory.keys.include?(item)
            if vendor.inventory[item] > desired_amount
              vendor.inventory[item] -= desired_amount
              desired_amount = 0
            elsif vendor.inventory[item] == desired_amount
              vendor.inventory[item] = 0
              desired_amount = 0
            else
              desired_amount -= vendor.inventory[item]
              vendor.inventory[item] = 0
            end
          end
        end
      end
      return true
    else
      return false
    end
  end
end

class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    names = []
    @vendors.each {|v| names.push(v.name)}
    names
  end

  def vendors_that_sell(item)
    stockists = []
    @vendors.each do |vendor|
      if vendor.inventory.keys.include?(item)
        stockists.push(vendor)
      end
    end
    stockists
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      items.push(vendor.inventory.keys)
    end
    (items.sort).flatten.uniq
  end

  def total_inventory
    haul = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amt|
        haul[item] += amt
      end
    end
    haul
  end

  def max_amount_sold(vendor, item, amount)
    max = 0
      if (vendor.inventory[item] - amount > 0)
        max = amount
      elsif (vendor.inventory[item] - amount < 0)
        max = vendor.inventory[item]
      end
    max
  end

  def sell(item, amount)
    return false if (vendors_that_sell(item).empty? || total_inventory[item] < amount)
    return true if (!vendors_that_sell(item).empty? || total_inventory[item] > amount) &&
      vendors_that_sell(item).each_with_object(amount) {|amount, vendor| (vendor.inventory[item] -= max_amount_sold(vendor, item, amount)) until amount < 0}
    end


  # def sell(item, amount)
  #   return false if (vendors_that_sell(item).empty? || total_inventory[item] < amount)
  #   return true if (!vendors_that_sell(item).empty? || total_inventory[item] > amount) &&
  #     vendors_that_sell(item)[0].inventory[item] -= max_amount_sold(vendors_that_sell(item)[0], item, amount)
  #
  #     vendors_that_sell(item)[1].inventory[item] -= (amount - max_amount_sold(vendors_that_sell(item)[0], item, amount))
  #   end

end

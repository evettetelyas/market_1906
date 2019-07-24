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

end

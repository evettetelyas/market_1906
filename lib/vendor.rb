class Vendor
  attr_reader :name
  attr_accessor :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    if @inventory.keys.include?(item)
      return @inventory[item]
    else return 0
    end
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

end

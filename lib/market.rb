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
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.reduce([]) do |acc, vendor|
      acc << vendor if vendor.inventory.include?(item)
      acc
    end
  end

  def sorted_item_list
    @vendors.reduce([]) do |acc, vendor|
      vendor.inventory.keys.each do |item|
        acc << item.name
      end
      acc
    end.uniq.sort
  end

end

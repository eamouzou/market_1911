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

  def total_inventory
    @vendors.reduce(Hash.new(0)) do |acc, vendor|
      vendor.inventory.each do |item|
        acc[item[0]] += item[1]
      end
      acc
    end
  end

  def sell(item, amount)
    if total_inventory[item] < amount
      false
    else
      amount_counter = amount
      @vendors.each do |vendor|
        vendor.inventory.each do |itemandamount|
          vendoritem = itemandamount[0]
          vendoramount = itemandamount[1]
          if vendoritem == item && amount_counter != 0
            if amount_counter > vendoramount
              vendor.sell_item(item, vendoramount)
              amount_counter -= vendoramount
            elsif amount_counter <= vendoramount
              vendor.sell_item(item, amount_counter)
              amount_counter -= vendoramount
            end
          end
        end
      end
      true
    end
  end

end

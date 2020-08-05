class Event

  attr_reader :name,
              :food_trucks
  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck|
      truck.inventory.include?(item)
    end
  end

  def total_inventory
    total_inventory_hash = Hash.new
    item_hash = Hash.new
    @food_trucks.each do |truck|
      truck.inventory.each do |item|
        total_inventory_hash[item[0]] = create_item_hash(item[0])
      end
    end
    total_inventory_hash
  end

  def create_item_hash(item)
    {
      :quantity => @food_trucks.sum do |truck|
                    truck.check_stock(item)
                  end,
      :food_trucks => food_trucks_that_sell(item)
    }
  end

end

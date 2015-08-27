class Seed
  def initialize
    build_lists
    build_items
  end

  def build_lists
    i = 1
    10.times do
      List.create(title: "Grocery List #{i}")
      i = i + 1
    end
  end

  def build_items
    i = 1
    10.times do
      Item.create(description: "Yummy Food", list_id: i )
      i = i + 1
    end
  end
end

Seed.new

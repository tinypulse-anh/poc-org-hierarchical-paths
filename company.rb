require './model'

class Company < Model
  attr_reader :hierarchy, :regions

  def initialize
    super
    @hierarchy = { "Company ##{@id}" => nil }
    @regions = []
  end

  def add_region(region)
    region.set_parent(self)
    @regions << region
  end

  def rebuild_hierarchy
    @hierarchy["Company ##{@id}"] = @regions.reduce({}) do |memo, region|
      memo["Region ##{region.id}"] = region.hierarchy
      memo
    end
  end
end

require './model'

class Region < Model
  attr_reader :hierarchy, :path, :parent, :children

  def initialize
    super

    @children = []
  end

  def set_parent(parent)
    @parent = parent
  end

  def add_child(child)
    child.is_a?(Region) ? child.set_parent(self) : child.set_region(self)
    @children << child
  end

  def size
    @children.size
  end

  def rebuild_hierarchy
    if children[0].is_a?(Organization)
      @hierarchy = children.map { |child| "Organization ##{child.id}" }
    else
      @hierarchy = @children.reduce({}) do |memo, child|
        memo["Region ##{child.id}"] = child.hierarchy
        memo
      end
    end
  end

  def rebuild_path
    @path = @parent.is_a?(Company) ? [] : @parent.path.clone
    @path << "Region ##{@id}"
  end
end

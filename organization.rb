class Organization < Model
  attr_reader :path, :region

  def set_region(region)
    @region = region
  end

  def rebuild_path
    @path = [*@region.path, "Organization ##{@id}"]
  end
end

class Model
  def self.inherited(base)
    base.instance_eval do
      class << self; attr_accessor :current_id; end
      self.current_id = 0

      attr_reader :id
    end
  end

  def initialize
    @id = (self.class.current_id += 1)
  end
end

class Neo
  attr_reader :name,
              :reference_id
  def initialize(attributes = {})
    @name = attributes[:name]
    @reference_id = attributes[:neo_reference_id]
  end
end

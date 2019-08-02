class Volunteer
  attr_reader :id
  attr_accessor :name, :volunteer_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @volunteer_id = attributes.fetch(:volunteer_id)
    @id = attributes.fetch(:id)
  end

  
end

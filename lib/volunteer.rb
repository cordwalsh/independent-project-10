class Volunteer
  attr_reader :id
  attr_accessor :name, :album_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @album_id = attributes.fetch(:album_id)
    @id = attributes.fetch(:id)
  end

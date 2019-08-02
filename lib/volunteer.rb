class Volunteer
  attr_reader :id
  attr_accessor :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteer;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = project.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

  def self.clear
    DB.exec("DELETE FROM volunteer *;")
  end

  def ==(volunteer_to_compare)
    self.name() == volunteer_to_compare.name()
  end

  # def save
  #   result = DB.exec("INSERT INTO volunteers (name, project_id, id) VALUES ('#{@name}', #{@project_id}, #{@id}) RETURNING id;")
  #   @id = result.first().fetch("id").to_i
  # end

end

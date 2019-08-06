require('./lib/project.rb')

class Volunteer
  attr_reader :id, :project_id
  attr_accessor :name

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

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteer WHERE id = #{id};").first
    if volunteer
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      Volunteer.new({:name => name, :id => id, :project_id => project_id})
    else
      nil
    end
  end

  def save
    result = DB.exec("INSERT INTO volunteer (name, project_id, id) VALUES ('#{@name}', '#{@project_id}', '#{@id}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  # def update(attributes)
  #   (attributes.key? :title) ? @title = attributes.fetch(:title) : @title = @title
  #   DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  # end
# ------------------- update above this is new one------------
  # def update(attributes)
  #   (attributes.key? :name) ? @name = attributes.fetch(:name) : @name = @name
  #   DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  # end

# #
#   def update(name)
#     @name = name
#     DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
#   end
#
# def delete
#   DB.exec("DELETE FROM albums WHERE id = #{@id};")
#   DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
# end

end

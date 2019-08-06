require('./lib/volunteer.rb')

class Project
  attr_accessor :title
  attr_reader :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.clear
    DB.exec("DELETE FROM projects *;")
  end


  def ==(project_to_compare)
    self.title() == project_to_compare.title()
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
# -------failing--------
  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    if project
      title = project.fetch("title")
      id = project.fetch("id").to_i
      Project.new({:title => title, :id => id})
    else
      nil
    end
  end

  def delete
  DB.exec("DELETE FROM volunteer_projects WHERE project_id = #{@id};")
  DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end


  def update(attributes)
    (attributes.key? :title) ? @title = attributes.fetch(:title) : @title = @title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

end
#   def albums
#     albums = []
#     results = DB.exec("SELECT album_id FROM albums_artists WHERE artist_id = #{@id};")
#     results.each() do |result|
#       album_id = result.fetch("album_id").to_i()
#       album = DB.exec("SELECT * FROM albums WHERE id = #{album_id};")
#       name = album.first().fetch("name")
#       albums.push(Album.new({:name => name, :id => album_id}))
#     end
#     albums
#     # a way to avoid n+1 query using subquery technique....
#     results = DB.exec(%{
#       SELECT * FROM albums
#       WHERE id IN (
#         SELECT album_id FROM albums_artists
#         WHERE artist_id = #{@id});
#         })
#         results.map() do |result|
#           id = result.fetch("id").to_i()
#           name = result.fetch("name")
#           Album.new({:name => name, :id => id})
#     end
#   end

require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require("pg")
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  Project.all()
  redirect to('/projects')
end

get ('/projects') do
  @projects = Project.all
  erb(:projects)
end

get ('/projects/new') do
  erb(:new_project)
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:volunteers)
end

get ('/volunteers/new') do
  erb(:new_volunteer)
end

get ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:volunteers)
end

get ('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:edit_volunteer)
end

get ('/index') do
  @projects = Project.all()
  @volunteers = Volunteer.all()
end

post ('/projects') do
  title = params[:project_title]
  project = Project.new({:title => title, :id => nil })
  project.save
  redirect to('/')
end

post ('/volunteers') do
  name = params[:volunteer_name]
  volunteer = Volunteer.new({:name => name, :project_id => nil, :id => nil })
  volunteer.save
  redirect to('/volunteers')
end

post ('/projects/:project_id/volunteers') do
  @project = Project.find(params[:project_id].to_i())
  @project.update({:volunteer_name => params[:volunteer_name]})
  erb(:project)
end

patch ('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end

patch ('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.update(params[:name])
  redirect to('/volunteers')
end

patch ('/volunteer/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.update(:name => params[:name])
  @volunteer.save()
  redirect to ("/volunteer/#{@volunteer.id}")
end

delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end

delete ('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.delete()
  redirect to('/volunteers')
end

require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require("pg")
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  Project.clear()
  redirect to('/projects')
end

get ('/projects') do
  @projects = Project.all
  erb(:projects)
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

post ('/projects/:project_id/volunteers') do
  @project = Project.find(params[:project_id].to_i())
  @project.update({:volunteer_name => params[:volunteer_name]})
  erb(:project)
end

post ('/projects') do
  name = params[:project_name]
  project = Project.new({:name => name, :id => nil})
  project.save()
  redirect to('/projects')
end

patch ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:name])
  redirect to('/projects')
end

delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  redirect to('/projects')
end

get ('/index') do
  @projects = Project.all()
  @volunteers = Volunteer.all()
end

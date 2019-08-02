require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require("pg")
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker_test"})

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

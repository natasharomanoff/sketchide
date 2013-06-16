use Rack::MethodOverride

Mongoid.load!(File.dirname(__FILE__) + "/mongoid.yml")


class Sketch
  include Mongoid::Document
  field :title, type: String
  field :content, type:String
end


get '/' do 
	@sketches = Sketch.all
	haml :index
end

get '/sketches/new' do
	haml :new_sketch
end

get '/sketches/:id' do
  @sketch = Sketch.find(params[:id])
  haml :show_sketch
end

post '/sketches' do
  title = params[:title]
  content = params[:content]
  Sketch.create(:title => title, :content => content)

  redirect to('/')
end

get '/sketches/:id/edit' do
  @sketch = Sketch.find(params[:id])
  haml :edit_sketch
end

put '/sketches' do
  @sketch = Sketch.find(params[:id])
  @sketch.title = params[:title]
  @sketch.content = params[:content]
  @sketch.save

  redirect to("/sketches/#{@sketch.id}")
end

get '/sketches/:id/delete' do
  @sketch = Sketch.find(params[:id])
  haml :confirm_delete
end

delete '/sketches/:id' do
  @sketch = Sketch.find(params[:id])
  @sketch.delete

  redirect to("/")
end

get '/sketches/live/:id.pde' do
  sketch = Sketch.find(params[:id])
  sketch.content
end

get '/sketches/live/:id' do
  @sketch = Sketch.find(params[:id])
  haml :preview, :layout => false
end
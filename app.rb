require 'sinatra' 
require 'sinatra/reloader'
require 'sinatra/activerecord'
 
db = URI.parse('postgres://weightsnap:d39oUfaie@localhost/weightsnap')

ActiveRecord::Base.establish_connection(
  :adapter  => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
  :host     => db.host,
  :username => db.user,
  :password => db.password,
  :database => db.path[1..-1],
  :encoding => 'utf8'
	
)

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

helpers do
    include Rack::Utils
    alias_method :h, :escape_html
end
 
class Weight < ActiveRecord::Base
end
 
get '/' do
    @weights = Weight.order("id desc").to_a
    erb :index
end
 
post '/new' do
    Weight.create({:weight => params[:weight], :date => Time.now.strftime("%Y-%m-%d %H:%M:%S %Z") })
    redirect '/'
end
 
post '/delete' do
    Weight.find(params[:id]).destroy
end

require "sinatra"
require "rack-flash"
require "gschool_database_connection"

class Gohuntterrence < Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @database_connection = GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
  end

  get "/" do
    erb :registration
  end

  post "/registration" do
    name = params[:name]
    email = params[:email]
    if name == "" && email == ""
      flash[:notice] = "No name or password entered"
    elsif password == ""
      flash[:notice] = "No email entered"
    elsif username == ""
      flash[:notice] = "No username entered"
    else

      if @database_connection.sql("SELECT name from users where name = '#{name}'") == []
        @database_connection.sql("INSERT INTO users (name, email) values ('#{name}', '#{email}')")
        flash[:notice] = "Thank you for registering"
        redirect '/'
      end
    end
  end
  end
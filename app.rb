require "sinatra"
require "sequel"
require "moments"

DB = Sequel.connect(ENV.fetch("DATABASE_URL"))

DB.create_table?(:students) do
  primary_key :id
  String :name
  date :birthday
end

get "/" do
  @students = DB[:students].all
  erb :index
end

post "/" do
  name = String(params["name"])
  birthday = Date.parse(params["birthday"]) rescue nil
  if !name.empty? && birthday
    DB[:students].insert(name: name, birthday: birthday)
  end
  redirect to("/")
end

delete "/" do
  DB[:students].where(id: params["student_id"]).delete
  redirect to("/")
end

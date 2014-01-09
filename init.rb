require 'heroku/command/base'
require 'uri'

# manage elephantsql databases
# 
class Heroku::Command::ElephantSQL < Heroku::Command::Base
  def index
    display 'ElephantSQL'
  end

  # elephantsql:psql
  #
  # -c, --command COMMAND # optional SQL command to run
  #
  # Open a psql shell to the database specified at ELEPHANTSQL_URL
  #
  def psql
    vars = api.get_config_vars(app).body
    if url = vars['ELEPHANTSQL_URL']
      if command = options[:command]
        command = "-c '#{command}'"
      end
      exec "psql #{command} #{url}"
    else
      error "No ElephantSQL database found"
    end
  end

  # elephantsql:pg_dump
  #
  # Calls the pg_dump, can use all arguments as pg_dump can
  #
  def pg_dump
    vars = api.get_config_vars(app).body
    if url = vars['ELEPHANTSQL_URL']
      u = URI.parse url
      exec "env PGPASSWORD=#{u.password} pg_dump -h #{u.host} -p #{u.port || 5432} -U #{u.user} -d #{u.path[1..-1]} -cOx"
    else
      error "No ElephantSQL database found"
    end
  end
end


require 'heroku/command/base'

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
end

require 'heroku/command/base'

class Heroku::Command::ElephantSQL < Heroku::Command::Base
  def index
    display 'ElephantSQL'
  end

  def psql
    vars = api.get_config_vars(app).body
    if url = vars['ELEPHANTSQL_URL']
      exec "psql #{url}"
    else
      error "No ElephantSQL database found"
    end
  end
end

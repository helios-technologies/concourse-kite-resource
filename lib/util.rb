require 'json'

module Util
  def params(json_data)
    JSON.parse(json_data)
  end

  def log(msg)
    msg.split("\n").each do |l|
      STDERR.print('[LOG] ', l, "\n")
    end
  end

  def respond(version: {}, metadata: [])
    STDOUT.print JSON.generate({ version: version, metadata: metadata })
  end

  module_function :params
  module_function :log
  module_function :respond
end

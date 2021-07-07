require 'json'

module JSON_UTILS
  def self.load(route_json)
    file = File.read(route_json)
    JSON.parse(file)
  end

  def self.save(route_json, data_hash)
    File.write(route_json, JSON.dump(data_hash))
  end
end

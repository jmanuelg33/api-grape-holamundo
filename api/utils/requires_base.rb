# de donde estoy salgo 2 veces y entro a app/....*.rb segun cada lo cargo
Dir[File.expand_path('../../app/v1/entities/*.rb', __FILE__)].each do |entity|
  require_relative entity
end
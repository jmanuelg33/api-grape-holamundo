# frozen_string_literal: true

# Config class
class Config
  SYSTEM_LABEL = 'rack_'

  def self.load_config
    configs = {}
    ENV.each do |env_pair|
      key = env_pair[0]
      value = env_pair[1]
      if key.start_with?(SYSTEM_LABEL)
        key = key.sub(SYSTEM_LABEL, '')
        configs[key] = value
      end
    end
    configs
  end
end

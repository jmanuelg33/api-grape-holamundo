class AbstractFactory

  def initialize(tracking_number)
    @tracking_number = tracking_number
  end

  def track
    raise 'Don\'t forget to implement the track method'
  end
end

class Fedex < AbstractFactory
  def track; end
end

class Prueba2 < AbstractFactory
  def track; end
end

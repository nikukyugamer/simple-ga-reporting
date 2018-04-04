require './config/filters' # TODO: hard coding...

class LegatoModel
  extend Legato::Model
  extend Filters

  dimensions(*$model_config['dimensions']) # TODO: oh...global variable...
  metrics(*$model_config['metrics']) # TODO: oh...global variable...

  set_filters
end

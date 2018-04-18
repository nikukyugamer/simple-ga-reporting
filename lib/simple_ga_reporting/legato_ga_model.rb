require "./#{$filters_file}"

class LegatoGaModel
  extend Legato::Model
  extend Filters

  # TODO: oh...global variable...
  dimensions(*$model_config['dimensions'])
  metrics(*$model_config['metrics'])

  # TODO: 'Filters' is hard coding
  Filters.instance_methods.each do |symbol_method_name|
    send(symbol_method_name.to_s)
  end
end

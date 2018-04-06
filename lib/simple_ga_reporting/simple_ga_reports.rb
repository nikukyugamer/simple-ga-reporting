require 'simple_ga_reporting/legato_ga_user'

class SimpleGaReports
  extend LegatoGaUser
end

class << SimpleGaReports
  def configure(yaml_file='config/ga_reporting_config.yml', filters_file='config/filters.rb', **options)
    # TODO: oh... global variable...
    $model_config = YAML.load_file(yaml_file)
    $filters_file = filters_file

    require 'simple_ga_reporting/legato_ga_model'
    query_parameters($model_config, options)
  end

  def filtered_results(key_and_email_file)
    raw_results = raw_results(key_and_email_file)
    filtering(raw_results)
  end

  def raw_results(key_and_email_file)
    # 'legato_ga_model' method is generated by Model class automatically
    query = ga_profile(key_and_email_file).legato_ga_model

    query.results(
      start_date: @start_date,
      end_date: @end_date,
      limit: @limit,
      # offset: @offset,
      sort: @sort,
      # quota_user: @quota_user,
      sampling_level: @sampling_level,
      # segment_id: @segment_id,
    )
  end

  def filtering(results)
    if @filters
      @filters.each do |filter_symbol_name|
        results = results.send(filter_symbol_name) # TODO: oh... send method...
      end
    end

    results
  end

  # TODO: should specify by profile id, too
  def ga_profile(key_and_email_file)
    ga_user = create_ga_user(key_and_email_file)

    ga_user.profiles.each do |profile|
      return profile if profile.name === @profile_name
    end
  end

  # HACK: not cool descriptions
  def query_parameters(model_config, **options)
    @start_date     = options[:start_date] ? options[:start_date] : model_config['start_date']
    @end_date       = options[:end_date] ? options[:end_date] : model_config['end_date']
    @limit          = options[:limit] ? options[:limit] : model_config['limit']
    # @offset         = options[:offset] ? options[:offset] : model_config['offset']
    @sort           = options[:sort] ? options[:sort] : model_config['sort'] # Array
    # @quota_user     = options[:quota_user] ? options[:quota_user] : model_config['quota_user']
    @sampling_level = options[:sampling_level] ? options[:sampling_level] : 'HIGHER_PRECISION'
    # @segment_id     = options[:segment_id] ? options[:segment_id] : model_config['segment_id']
    @filters        = options[:filters] ? options[:filters] : model_config['filters'] # Array
    @profile_name   = options[:profile_name] ? options[:profile_name] : model_config['profile_name']

    # TODO: for RSpec
    {
      start_date: @start_date,
      end_date: @end_date,
      limit: @limit,
      offset: @offset,
      sort: @sort,
      quota_user: @quota_user,
      sampling_level: @sampling_level,
      segment_id: @segment_id,
      filters: @filters,
      profile_name: @profile_name,
    }
  end
end

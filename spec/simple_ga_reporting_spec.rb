require 'spec_helper'
require './config/filters'

describe 'Ruby Gem' do
  it 'バージョン番号を持つこと' do
    expect(SimpleGaReporting::VERSION).not_to be nil
  end
end

describe 'Google Analytics のデータを API で取得する' do
  before do
    @ga_reporting_config = YAML.load_file('config/sample_ga_reporting_config.yml')
    @required_keys = [
      'profile_name',
      'start_date',
      'end_date',
      'metrics',
    ]
  end

  describe '設定' do
    context 'API の設定が書いてある YAML' do
      it '必須のキーが存在する' do
        def keys_exist?
          @required_keys.each do |key|
            return false unless @ga_reporting_config.include?(key)
          end
          true
        end

        expect(keys_exist?).to eq true
      end

      it '必須のキーに対して値が存在する' do
        def values_exist?
          @ga_reporting_config.each do |key, value|
            if @required_keys.include?(key)
              return false if value.nil?
            end
          end
          true
        end

        expect(values_exist?).to eq true
      end

      it 'フィルターに記述されているメソッドがフィルターファイルに存在する' do
        def methods_exist?
          instance_methods = Filters.instance_methods(false)

          @ga_reporting_config['filters'].each do |filter_method|
            return false unless instance_methods.include?(filter_method.to_sym)
          end
          true
        end

        expect(methods_exist?).to eq true
      end
    end

    context 'フィルターが記述されているファイル' do
      it 'Ruby の文法として正しい' do
        expect(Filters.class).to eq Module
      end
    end
  end

  describe 'クエリパラメータ' do
    context 'options を引数として持たない場合' do
      it '正しく取得できること' do
        def query_parameters_valid?
          instance_variables = SimpleGaReports.query_parameters(@ga_reporting_config)

          instance_variables.each do |key, value|
            if key === :sampling_level
              @ga_reporting_config[key.to_s] = 'HIGHER_PRECISION'
            end
            return false unless @ga_reporting_config[key.to_s] === value
          end

          true
        end

        expect(query_parameters_valid?).to eq true
      end
    end

    context 'options を引数として持つ場合' do
      it '正しく取得できること' do
        def query_parameters_valid?
          options = { start_date: 'yesterday', limit: 150 }
          instance_variables = SimpleGaReports.query_parameters(@ga_reporting_config, options)

          instance_variables.each do |key, value|
            case key
            when :sampling_level
              @ga_reporting_config[key.to_s] = 'HIGHER_PRECISION'
            when :start_date
              @ga_reporting_config[key.to_s] = 'yesterday'
            when :limit
              @ga_reporting_config[key.to_s] = 150
            end

            return false unless @ga_reporting_config[key.to_s] === value
          end

          true
        end

        expect(query_parameters_valid?).to eq true
      end
    end
  end

  describe 'Legatoユーザーオブジェクト' do
    context 'private_key を' do
      it '設定ファイルから正しく取得する' do
        key_by_method = SimpleGaReports.private_key('config/sample_key_and_email.yml')
        key_from_yaml = YAML.load_file('config/sample_key_and_email.yml')['private_key']

        expect(key_by_method === key_from_yaml).to eq true
      end
    end

    context 'client_email を' do
      it '設定ファイルから正しく取得する' do
        email_by_method = SimpleGaReports.client_email('config/sample_key_and_email.yml')
        email_from_yaml = YAML.load_file('config/sample_key_and_email.yml')['client_email']

        expect(email_by_method === email_from_yaml).to eq true
      end
    end
  end
end

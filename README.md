# What's this?
This gem helps you to obtain `Google Analytics` reporting data with ease.
 
First of all, you create configuration YAML file as Google Analytics API. Then execute the simple Ruby code, and you obtain Google Analytics reporting data.

Yeah, very simple :)

## Wrapper gem of Legato
This gem is wrapper of [Legato gem](https://github.com/tpitale/legato). `Legato` is very coooooooool gem and full-stack gem, so complicated one as a beginner (as me!).  

So I developed this wrapper gem, `simple-ga-reporting`.

# Usage

## 1. Installation
```bash
$ gem install simple-ga-reporting
```

## 2. Create API configuration file
- You must create `config/key_and_email.yml`
    - The directory name and filename are determined (sorry...)
- This YAML file must contain two key-value sets 
    - `private_key`
    - `client_email`
- How to get above two sets is written later

## 3. Create Google Analytics reporting configuration file
- You must create the YAML file(s) which contains Google Analytics reporting configuration such as `start-date`, `end-date`, `metrics`, `demensions`, `filters` and etc.
- This YAML file format is written later

## 4. Create filters file (Optional)
- If you wanna use `filter`, please create `config/filters.rb`
    - The directory name and filename are determined (sorry...)
- the filters configuration on GUI is below

![filter configuration on GUI](images/simple-ga-reporting_filter.png)

## 5. Write your app
- You write your application using this gem
- The sample code is below
    - Only three lines :-)

```ruby
require 'simple_ga_reporting'

SimpleGaReports.configure('your_reporting_config_file.yml')
SimpleGaReports.results #=> Legato::Query
```

# Very Awesome Reference Book
- [わかばちゃんと学ぶ Googleアナリティクス](http://www.c-r.com/book/detail/1217)

![わかばちゃんと学ぶ Googleアナリティクス](http://www.c-r.com/book/images/x/86354-232-7_x.jpg)

- Japanese only
    - English version will...?

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/corselia/simple-ga-reporting. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EasyGa project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/corselia/simple-ga-reporting/blob/master/CODE_OF_CONDUCT.md).

# TODO
- RSpec
- CI
- coverage

# below, under writing...

# Quick Start
https://developers.google.com/analytics/devguides/config/mgmt/v3/quickstart/service-php?hl=ja

# API Rate Limits
- https://developers.google.com/analytics/devguides/reporting/core/v3/limits-quotas?hl=ja

# Required
- GOOGLE_ANALYTICS_API_KEY
    - "-----BEGIN PRIVATE KEY-----\nMII..........JxvEqw==\n-----END PRIVATE KEY-----\n"
- ISSUER
    - "fooooo-baaaa@xxxxxxxxxx-yyyy-123.iam.gserviceaccount.com"
- config
    - `config/your_config_file.yml`

```yaml
profile_name: 'Your Profile Name'
dimensions:
  - date
metrics:
  - users
  - pageviews
filters:
start_date: 7daysAgo
end_date: 1daysAgo
limit: 10
sort:
  - -date
```

- filters
    - optional
    - you need to edit `config/filters.rb` as you like

```
Reporting API
以下の割り当ては、Core Reporting API v3、アナリティクス Reporting API v4、Realtime API v3、Multi-channel Funnel API v3 など、すべての Reporting API に適用されます。

ビュー（旧プロファイル）ごとに 1 日 10,000 件のリクエスト（引き上げ不可）
ビュー（旧プロファイル）ごとに 10 件の同時リクエスト（引き上げ不可）
注: バッチ処理で複数の Reporting API リクエストを 1 回のリクエストにまとめても、定められた割り当て量を超えるリクエストを実行することはできません。
```

# use
- not gem install google-api-client
- [Legato](https://github.com/)'s wrapper

# Usage
- `bundle install`
- `require`
- `config/`
    - `config/your_config_file.yml`
        - you can create many YAML files
    - `config/filters.rb`
    - `config/ga_config.rb`
        - `API_KEY`
        - `ISSUER` 

# Config File Formats
- YAML file
    - example...
    - official document uri
- filters file
    - use lambda statement

# TODO
- can input not only `profile_name` but also `view id`

# Official Documents
- [Query Explorer — Google Analytics Demos & Tools](https://ga-dev-tools.appspot.com/query-explorer/?hl=ja)
- [Dimensions & Metrics Explorer  |  アナリティクス Reporting API v4  |  Google Developers](https://developers.google.com/analytics/devguides/reporting/core/dimsmets)

# クエリエクスプローラでの設定項目
- https://ga-dev-tools.appspot.com/query-explorer/?hl=ja
- Set the query parameters
    - ids
    - start-date
    - end-date
    - metrics
    - dimensions
    - sort
    - filters
    - segment
    - samplingLevel
    - include-empty-rows
    - start-index
    - max-results

# あとでまとめる

```
 - https://ga-dev-tools.appspot.com/query-explorer/?hl=ja
 options[:start-date]...
 - ids #=> optionsで変更不可
 - start-date #=> start_date
 - end-date #=> end_date
 - metrics # Array #=> optionsで変更不可
 - dimensions # Array #=> optionsで変更不可
 - sort #=> optionsで変更不可
 - filters
 - segment #=> 未実装。nilだとエラーが出る。
 {"errors"=>[{"domain"=>"global", "reason"=>"invalidParameter", "message"=>"Invalid value 'gaid::' for segment parameter."}], "code"=>400, "message"=>"Invalid value 'gaid::' for segment parameter."}:  (OAuth2::Error)
 {"error":{"errors":[{"domain":"global","reason":"invalidParameter","message":"Invalid value 'gaid::' for segment parameter."}],"code":400,"message":"Invalid value 'gaid::' for segment parameter."}}
 - samplingLevel #=> default は HIGH
 - include-empty-rows #=> include_empty_rows # なにこれ……
 - start-index #=> start_index # なにこれ……
 - max-results #=> max_results # Legatoでいう limit のことだと思う（要確認）
```

```
 こちらは Legato のシンボルの定義
 :start_date - The date of the period you would like this report to start
 :end_date - The date to end, inclusive
 :limit - The maximum number of results to be returned
 :offset - The starting index
 :sort - metric/dimension to sort by
 :quota_user - any arbitrary string that uniquely identifies a user (40 characters max)
 :sampling_level - 'FASTER' or 'HIGHER_PRECISION' https://developers.google.com/analytics/devguides/reporting/core/v3/reference#samplingLevel
 :segment_id - this will supersede any segments chained to the query
```

```
    # - https://ga-dev-tools.appspot.com/query-explorer/?hl=ja
    # options[:start-date]...
    # - ids #=> optionsで変更不可
    # - start-date #=> start_date
    # - end-date #=> end_date
    # - metrics # Array #=> optionsで変更不可
    # - dimensions # Array #=> optionsで変更不可
    # - sort #=> optionsで変更不可
    # - filters
    # - segment #=> 未実装。nilだとエラーが出る。
    # {"errors"=>[{"domain"=>"global", "reason"=>"invalidParameter", "message"=>"Invalid value 'gaid::' for segment parameter."}], "code"=>400, "message"=>"Invalid value 'gaid::' for segment parameter."}:  (OAuth2::Error)
    # {"error":{"errors":[{"domain":"global","reason":"invalidParameter","message":"Invalid value 'gaid::' for segment parameter."}],"code":400,"message":"Invalid value 'gaid::' for segment parameter."}}
    # - samplingLevel #=> default は HIGH
    # - include-empty-rows #=> include_empty_rows # なにこれ……
    # - start-index #=> start_index # なにこれ……
    # - max-results #=> max_results # Legatoでいう limit のことだと思う（要確認）

    # こちらは Legato のシンボルの定義
    # :start_date - The date of the period you would like this report to start
    # :end_date - The date to end, inclusive
    # :limit - The maximum number of results to be returned
    # :offset - The starting index
    # :sort - metric/dimension to sort by
    # :quota_user - any arbitrary string that uniquely identifies a user (40 characters max)
    # :sampling_level - 'FASTER' or 'HIGHER_PRECISION' https://developers.google.com/analytics/devguides/reporting/core/v3/reference#samplingLevel
    # :segment_id - this will supersede any segments chained to the query
```

```
  AND-Filter: using method-chain
  OR-Filter Pattern_01: ref below
  filter :browsers) {|*browsers| browsers.map {|browser| matches(:browser, browser)}}
  OR-Filter Pattern_02: ref below (with regexp)
  filter :or_filter_pattern_02, &lambda {contains(:pagePath, 'Firefox|Safari')}
```

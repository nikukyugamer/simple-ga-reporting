# What's this?
This gem helps you to obtain `Google Analytics` reporting data with ease.
 
First of all, you create configuration YAML file as Google Analytics API. Then execute the simple Ruby code, and you obtain Google Analytics reporting data.

Yeah, very simple :)

## Wrapper gem of Legato
This gem is a wrapper of [Legato gem](https://github.com/tpitale/legato). `Legato` is very coooooooool and full-stack gem, so complicated as a beginner (me!).  

So I developed this wrapper gem, `simple-ga-reporting`.

# Usage

## 1. Installation
```bash
$ gem install simple-ga-reporting
```

## 2. Create API configuration file
- You must create `config/key_and_email.yml`
    - filepath and filename can be changed
- This YAML file must contain two Key-Value sets 
    - `private_key`
        - its key
    - `client_email`
        - its email
- How to get above two Key-Value sets is written later

## 3. Create Google Analytics reporting configuration file
- You must create the YAML file which contains Google Analytics reporting configuration such as `start-date`, `end-date`, `metrics`, `demensions`, `filters` and etc.
- This YAML file format is written later

## 4. Create filters file (Optional)
- If you wanna use `filter`, please create `config/filters.rb`
    - filepath and filename can be changed
- for instance, the filters configuration on GUI is below

![filter configuration on GUI](images/simple-ga-reporting_filter.png)

## 5. Write your app
- Write your application used this gem
- The sample code is below
    - Only three lines :-)

```ruby
require 'simple_ga_reporting'

SimpleGaReports.configure
SimpleGaReports.filtered_results #=> Legato::Query
```

- configure method can get three arguments
    - yaml_file='config/ga_reporting_config.yml'
    - filters_file='./config/filters'
    - **options
- filtered_results can get one argument
    - key_and_email_file

# Configuration files

## API configuration file
- You must create Google Analytics API configuration file
    - `YAML`
    - You can give it any filename
    - Deafult filepath is ``
- Sample is below

```yaml
private_key: "-----BEGIN PRIVATE KEY-----\nMIIE..........Eqw==\n-----END PRIVATE KEY-----\n"
client_email: "your_account_name@foobar.iam.gserviceaccount.com"
```

## Google Analytics reporting configuration file
- You must create the YAML file which contains Google Analytics reporting configuration
- Sample is below

```yaml
profile_name: my_profile_name
start_date: 2018-04-01
end_date: 2018-04-05
metrics:
  - users
  - pageviews
dimensions:
  - pagePath
  - pageTitle
sort:
  - -pageviews
  - -users
filters:
  - my_awesome_filter
  - his_awesome_filter
  - her_awesome_filter
limit: 20
```

- Please refer the official documents as configuration Key-Value sets
    - https://developers.google.com/analytics/devguides/reporting/core/v3/reference

![ga_query_parametes_summary.png](images/ga_query_parametes_summary.png)
 
- In documents, you can config only several sets as below
    - start-date
    - end-date
    - metrics
    - dimensions
    - sort
    - filters
    - max-results

- Some Key names in configure file are different from ones in official document
    - `start_date` in configure file (using underscore)
    - `end_date` in configure file (using underscore)
    - `limit` ins configure file (instead of `max-results`)

- The type of `metrics`, `dimensions`, `sort` and `filters` is `Array`
    - The order doesn't matter

#### profile_name
- called `view` before
 

#### start_date
- REQUIRED
- Original Key name is `start-date`
- Value examples
    - `2018-04-01`
    - `today` or `yesterday`
    - `14daysAgo`
        - use `daysAgo` phrase even if `1day`

#### end_date
- REQUIRED
- Original Key name is `end-date`
- Value examples are the same as `start-date`

#### metrics
- REQUIRED
- `指標` in Japanese
- Official documents are below (very useful!)
    - [Dimensions & Metrics Explorer](https://developers.google.com/analytics/devguides/reporting/core/dimsmets)

![Dimensions & Metrics Explorer](images/dimensions_and_metrics_explorer.png)

- Value examples
    - `users`
    - `uniquePageviews`

#### dimensions
- optional
- Official documents are below (very useful!)
    - [Dimensions & Metrics Explorer](https://developers.google.com/analytics/devguides/reporting/core/dimsmets)
- Value examples
    - `pagePath`
    - `sessionCount`

#### sort
- optional
- Value examples
  - `-pageviews`
  - `users`
- Don't use `+` sign

#### filters
- optional
- Value is method name you named in `filters.rb`

#### limit
- optional
- Original Key name is `max-results`
- Value is max amount of returned rows
 
## filters file
- You use filters function using `filters.rb` file
    - the filename `filters.rb` is determined
    - filepath is optional

  AND-Filter: using method-chain
  OR-Filter Pattern_01: ref below
  filter :browsers) {|*browsers| browsers.map {|browser| matches(:browser, browser)}}
  OR-Filter Pattern_02: ref below (with regexp)
  filter :or_filter_pattern_02, &lambda {contains(:pagePath, 'Firefox|Safari')}







# Sample App










# Very Awesome Reference Book (Recommended)
- [わかばちゃんと学ぶ Googleアナリティクス (Let's study Google Analytics with Wakaba-Chan)](http://www.c-r.com/book/detail/1217)

![わかばちゃんと学ぶ Googleアナリティクス](http://www.c-r.com/book/images/x/86354-232-7_x.jpg)

- Created by [Ai Minatogawa](https://llminatoll.github.io/)
    - She is an energetic creator!
- Japanese version only
    - English version will...?

# Official documents

## API Rate Limits
- https://developers.google.com/analytics/devguides/reporting/core/v3/limits-quotas


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/corselia/simple-ga-reporting. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SimpleGaReporting project’s codebases, issue trackers, chat rooms and mailing lists is 
expected to follow the [code of conduct](https://github.com/corselia/simple-ga-reporting/blob/master/CODE_OF_CONDUCT.md).

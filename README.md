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
- This YAML file must contain two key-value sets 
    - `private_key`
        - its key
    - `client_email`
        - its email
- How to get above two sets is written later

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
SimpleGaReports.results #=> Legato::Query
```

# Google Analytics Documents

## Official Documents




# Very Awesome Reference Book
- [わかばちゃんと学ぶ Googleアナリティクス](http://www.c-r.com/book/detail/1217)
    - Let's study Google Analytics with Wakaba-Chan

![わかばちゃんと学ぶ Googleアナリティクス](http://www.c-r.com/book/images/x/86354-232-7_x.jpg)

- Japanese only
    - English version will...?
- Written by [Ai Minatogawa](https://llminatoll.github.io/)

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



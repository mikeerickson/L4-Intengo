#Make sure to do rvm use <ruby_version> once you ssh into vagrant

#Todos
 - [ ] Get rvm to use correctly
 - [x] Fix the sed command in php to remove the disable_functions

 IMPORTANT! Some of the defaults have changed in Capybara 2.1. If you're experiencing failures,
please revert to the old behaviour by setting:

    Capybara.configure do |config|
      config.match = :one
      config.exact_options = true
      config.ignore_hidden_elements = true
      config.visible_text_only = true
    end

If you're migrating from Capybara 1.x, try:

    Capybara.configure do |config|
      config.match = :prefer_exact
      config.ignore_hidden_elements = false
    end

Details here: http://www.elabs.se/blog/60-introducing-capybara-2-1
# Savage Beast Demo

This is a Rails app that demonstrates using [savage-beast](http://github.com/wbharding/savage-beast),
the forum plugin that is based on the popular Beast forum.

## Try it

1. `git clone git://github.com/hatem/savage-beast-demo.git`
2. `cd savage-beast-demo`
3. Install required gems: `rake gems:install`
4. Run the app: `script/server`
5. Click the "forums" link and enjoy

## Use it

1. Implement `login_required` and `current_user` in your `application_controller.rb`
2. Implement `display_name` and `admin?` in user model `user.rb`
3. To override, create files in your /controllers or /views directories with the same name
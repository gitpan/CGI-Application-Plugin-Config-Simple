#!/usr/bin/perl
use Test::More 'no_plan';
use lib './blib/lib';
use strict;


#test that we have the modules we need
require_ok('CGI::Application::Plugin');
require_ok('CGI::Application::Plugin::Config::Simple');
#create an empty hash to represent a C::A::P::C::S object
my $self = bless {}, 'CGI::Application::Plugin::Config::Simple';

#ok, set the environment variable to make sure we can get that 
$ENV{CGIAPP_CONFIG_FILE} = 't/test.ini';
my $value = $self->config_file();
is($value, 't/test.ini', 'Config file name from %ENV');

#now let's get a few parameters
$value = $self->config_param('block1.param11');
is($value, 'value11', 'Simple ini-file param 1');
$value = $self->config_param('block2.param22');
is($value, 'value22', 'Simple ini-file param 2');

#now let's set some parameters
$value = $self->config_param('block1.param11' => 'testing11', 'block2.param22' => 'testing22');
ok($value, 'Set ini-file params 1');
#and test their values
$value = $self->config_param('block1.param11');
is($value, 'testing11', 'Simple ini-file param 1');
$value = $self->config_param('block2.param22');
is($value, 'testing22', 'Simple ini-file param 2');
#now let's set them back
$value = $self->config_param('block1.param11' => 'value11', 'block2.param22' => 'value22');
ok($value, 'Set ini-file params 2');

#now let's get all of the values in a hash
$value = $self->config_param();
is(ref($value), 'HASH', 'Get all ini-file params');

#now let's test this hash's values
is($value->{'block1.param11'}, 'value11', 'Testing individual elements of entire config hash 1');
is($value->{'block2.param22'}, 'value22', 'Testing individual elements of entire config hash 2');

#now let's change config files
$value = $self->config_file('t/test.conf');
is($value, 't/test.conf', 'Change config file');

#now let's test these values
$value = $self->config_param('param1');
is($value, 'value1', 'Simple config param 1');
$value = $self->config_param('param2');
is($value, 'value2', 'Simple config param 2');
$value = $self->config_param('param3');
is($value, 'value3', 'Simple config param 3');

#now let's test the config() method to see if we get a Config::Simple object
$value = $self->config();
is(ref($value), 'Config::Simple', 'config() returned object');




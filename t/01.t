use strict;
use warnings;

use Test::More;
use Test::Exception;

use Data::Dump qw/dump/;

use lib 't/lib';
use lib 'lib';

require_ok('DBICx::Generator::ExtJS');

my $generator;

throws_ok {$generator= DBICx::Generator::ExtJS->new()} 
  qr/Attribute \(schema_name\) is required/, 
  'schema_name parameter required';

throws_ok {$generator = DBICx::Generator::ExtJS->new(schema_name => 'Sorry::No::Schema::Here')} 
  qr/Unable to found\/load Sorry::No::Schema::Here/, 
  'non existent schema detected';

ok($generator = DBICx::Generator::ExtJS->new(schema_name => 'My::Schema'), 'existant schema loaded correctly');

is_deeply($generator->tables, [qw/Another Basic/], 'schema tables found');

ok($generator->model('Basic'), 'ExtJS Basic model generation');

die dump($generator->model('Basic'));

done_testing;
use inc::Module::Install;
use Module::Install::AuthorTests;
use Module::Install::Repository;

name 'Cocoa-GuiTest';
all_from 'lib/Cocoa/GuiTest.pm';

test_requires 'Test::More' => 0.98;

tests 't/*.t';
author_tests 'xt';

auto_set_repository;

WriteAll;

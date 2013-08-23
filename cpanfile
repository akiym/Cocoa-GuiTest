requires 'XSLoader', '0.02';

on configure => sub {
    requires 'Devel::PPPort', '3.20';
    requires 'ExtUtils::ParseXS', '2.21';
};

on build => sub {
    requires 'Devel::PPPort', '3.20';
    requires 'ExtUtils::MakeMaker', '6.36';
    requires 'ExtUtils::ParseXS', '2.21';
    requires 'Test::More', '0.98';
};

# Getting Started

## Ruby Version
2.1.3

## RVM Gemset
vacation_tracker

## Database Creation
```
$ psql
> create database vacation_tracker_development;
> create database vacation_tracker_test;
> create user vacation_tracker_user with password '';
> grant all privileges on database vacation_tracker_development to vacation_tracker_user;
> grant all privileges on database vacation_tracker_test to vacation_tracker_user;
> alter role vacation_tracker_user with createdb;
> alter database vacation_tracker_development owner to vacation_tracker_user;
> alter database vacation_tracker_test owner to vacation_tracker_user;
> \q
```

## Database Initialization
```
$ rake db:drop db:create db:migrate db:seed
```

## How to Setup the Environment
```
$ echo "RACK_ENV=development" >> .env
$ echo "PORT=3000" >> .env
```

## How to Run the Application
```
$ foreman start
```




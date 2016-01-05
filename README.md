# APIBucket
[![Build Status](https://semaphoreci.com/api/v1/projects/2a6fea76-4420-480b-a505-c11d320eede5/635729/badge.svg)](https://semaphoreci.com/tobi-oduah/apibucket) [![Code Climate](https://codeclimate.com/github/andela-toduah/apibucket/badges/gpa.svg)](https://codeclimate.com/github/andela-toduah/apibucket) [![Test Coverage](https://codeclimate.com/github/andela-toduah/apibucket/badges/coverage.svg)](https://codeclimate.com/github/andela-toduah/apibucket/coverage)

## Features
APIBucket is an API service that allows users create bucketlists to store items. Bucketlists are initialized with a name, and an optional list of Items. Items are stored under bucketlists, with a name and a done-status indicating whether Item is completed or not.

For full access to the API, a user account is required. After registration, an initial request is made to log in to user account. This request generates a JSON Web Token, which is returned in the response. This token is used to authenticate subsequent requests to the API. 

For full documentation, and usage examples, see http://docs.apibucket.apiary.io/

##API endpoints for Bucketlists.

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /auth/login                        | Logs a user in                       |
| GET /auth/logout                        | Logs a user out                      |
| POST /bucketlists/                      | Create a new bucket list             |
| GET /bucketlists/                       | List all the created bucket lists    |
| GET /bucketlists/:id                    | Get single bucket list               |
| PUT /bucketlists/:id                    | Update this bucket list              |
| DELETE /bucketlists/:id                 | Delete this single bucket list       |
| POST /bucketlists/:id/items/            | Create a new item in bucket list     |
| PUT /bucketlists/:id/items/:item_id     | Update a bucket list items           |
| DELETE /bucketlists/:id/items/:item_id  | Delete an item in a bucket lists     |


## Limitations
OAuth access not yet implemented.

## Installation
Web application is written with Ruby using the Ruby on Rails framework.

To install Ruby visit [Ruby Lang](https://www.ruby-lang.org). [v2.2.3p173]

To install Rails visit [Ruby on Rails](http://rubyonrails.org/). [v4.2.4]

## Dependencies
User authentication is implemented with the JWT gem. For more information, see https://github.com/jwt/ruby-jwt

User authorization is implemented with the CanCanCan gem. For more information, see https://github.com/CanCanCommunity/cancancan

Service objects were implemented by extending the SimpleCommand gem. See https://github.com/nebulab/simple_command

ActiveModelSerializer was used while serializing objects for JSON responses. See https://github.com/rails-api/active_model_serializers

## Testing

Before running tests, run the following command to run all database migrations:

        $ bundle exec rake db:migrate

Before running tests, run the following command to seed the database:

        $ bundle exec rake db:seed

To test the web application, run the following command to carry out all tests:

        $ bundle exec rake spec

To view test descriptors, run the following command:

        $ bundle exec rake spec -fd

## Contributing

1. Fork it by visiting - https://github.com/andela-toduah/apibucket/fork

2. Create your feature branch

        $ git checkout -b new_feature
    
3. Contribute to code

4. Commit changes made

        $ git commit -a -m 'descriptive_message_about_change'
    
5. Push to branch created

        $ git push origin new_feature
    
6. Then, create a new Pull Request

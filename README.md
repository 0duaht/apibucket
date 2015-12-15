# APIBucket
[![Build Status](https://semaphoreci.com/api/v1/projects/2a6fea76-4420-480b-a505-c11d320eede5/635729/badge.svg)](https://semaphoreci.com/tobi-oduah/apibucket) [![Code Climate](https://codeclimate.com/github/andela-toduah/apibucket/badges/gpa.svg)](https://codeclimate.com/github/andela-toduah/apibucket) [![Test Coverage](https://codeclimate.com/github/andela-toduah/apibucket/badges/coverage.svg)](https://codeclimate.com/github/andela-toduah/apibucket/coverage)

##API endpoints for Bucketlists.
| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /auth/login                        | Logs a user in                       |
| GET /auth/logout                        | Logs a user out                      |
| POST /bucketlists/                      | Create a new bucket list             |
| GET /bucketlists/                       | List all the created bucket lists    |
| GET /bucketlists/<id>                   | Get single bucket list               |
| PUT /bucketlists/<id>                   | Update this bucket list              |
| DELETE /bucketlists/<id>                | Delete this single bucket list       |
| POST /bucketlists/<id>/items/           | Create a new item in bucket list     |
| PUT /bucketlists/<id>/items/<item_id>   | Update a bucket list items           |
| DELETE /bucketlists/<id>/items/<item_id>| Delete an item in a bucket lists     |
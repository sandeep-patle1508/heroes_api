# Hero Data API

A simple web application that provides information about Overwatch heroes and their abilities according to the JSONAPI (http://jsonapi.org) spec.

We are using https://overwatch-api.net/ API to fetch hero and ability data.

Available End Points -
- http:///api/heros - hero list
- /api/heros/{hero_id} - hero data
- /api/heros/{hero_id}/abilities - hero ability list
- /api/abilities/ - ability list
- /api/abilities/{ability_id} - ability data

## Tools
* Ruby 2.5.1p57
* Rails 2.5.1
* HTTParty Gem
* Rspec
* webmock

## Installation
`docker-compose build`

## Run locally
Start webserver -
`docker-compose up`
Now you can access API via localhost:3000

You can run docker container in background -
`docker-compose up -d`

Shut down webserver -
`docker-compose down`

## Run Testcases
`docker-compose run web rspec`
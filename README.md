# Customer Invite API

This is a Ruby on Rails API that processes customer data from a JSON lines file and filters customers within 100km of our Mumbai office for an invite.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoint](#api-endpoint)
- [Testing](#testing)
- [Directory Structure](#directory-structure)
- [Contributing](#contributing)

## Requirements

- Ruby 2.6.5
- Rails 6.0.6
- Bundler
- Git

## Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/akshay2408/customer_invite.git
   cd customer_invite
   ```

2. **Install dependencies:**

   ```sh
   bundle install
   ```

3. **Set up the database:**

   ```sh
   rails db:create
   rails db:migrate
   ```

## Usage

1. **Start the Rails server:**

   ```sh
   rails server
   ```

2. **Upload the customers.txt file through the API endpoint:**

You can use tools like curl or Postman to upload the file.

Example using curl:

    ```sh
    curl -X POST -F "file=@path/to/customers.txt" http://localhost:3000/customers
    ```

3. **Response:**

The API will return a JSON array of customers within 100km of the Mumbai office, sorted by user ID.

## API Endpoint

Description: Uploads a customers.txt file and returns customers within 100km of the Mumbai office.

Request:

Method: POST
URL: http://localhost:3000/customers
Body: Multipart form-data with the file parameter containing the customers.txt file.
Response:

Status: 200 OK
Body: JSON array of customers within 100km of the Mumbai office, sorted by user ID

[
{
"user_id": 1,
"name": "Aarav Patel"
},
{
"user_id": 2,
"name": "Vivaan Sharma"
},
...
]

## Testing

1. **Run the RSpec tests:**

   ```sh
   bundle exec rspec
   ```

## Directory Structure

customer_invite/
├── app/
│ ├── controllers/
│ │ └── customers_controller.rb
│ ├── services/
│ │ └── customer_inviter_service.rb
│ └── ...
├── spec/
│ ├── controllers/
│ │ └── customers_controller_spec.rb
│ ├── services/
│ │ └── customer_inviter_service_spec.rb
│ └── fixtures/
│ └── files/
│ └── customers.txt
├── config/
├── db/
├── README.md
└── ...

## Contributing

1. **Fork the repository.**

2. **Create a new branch:**

```sh
git checkout -b feature-branch
```

3. **Commit your changes:**

```sh
git commit -m 'Add new feature'
```

4. **Push to the branch:**

```sh
git push origin feature-branch
```

5. **Create a new Pull Request.**

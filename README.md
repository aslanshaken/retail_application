# Ruby on Rails Retail Management System

## Introduction
Welcome to the Ruby on Rails Retail Management System! This application serves as a platform for managing products within a retail environment. It provides a set of APIs to handle various product-related operations.

## Features
1. **List Active Products**: Retrieve a list of active products sorted by the latest first.
2. **Search Products**: Search for products based on various criteria such as product name, price range, and posted date range.
3. **Create a Product**: Add a new product to the system. If the price exceeds certain thresholds, the product may be sent to the approval queue.
4. **Update a Product**: Modify an existing product. Price updates may trigger a review process if they exceed 50% of the previous price.
5. **Delete a Product**: Remove a product from the system. Deleted products are pushed to the approval queue for further review.
6. **View Products in Approval Queue**: Retrieve a list of products pending approval, sorted by request date.
7. **Approve a Product**: Approve a product from the approval queue, updating its state accordingly.
8. **Reject a Product**: Reject a product from the approval queue while maintaining its current state.

## Implementation Details
- **Database Design**: The application utilizes a relational database PostgreSQL to store product information and manage the approval queue.
- **API Endpoints**: The API endpoints are designed to conform to RESTful principles for ease of use and integration.
- **Error Handling**: The system handles various error scenarios and provides appropriate error responses to clients.
- **Data Validations**: Robust data validations are in place to ensure the integrity and consistency of the data.
- **Security**: Measures are taken to secure the APIs and prevent unauthorized access to sensitive information.

## Getting Started
To start using the Ruby on Rails Retail Management System, follow these steps:
1. Clone the repository to your local machine.
2. Install dependencies using Bundler: `bundle install`.
3. Configure the database settings in `config/database.yml` to match your environment.
4. Run migrations to create the necessary database tables: `rails db:migrate`.
5. Start the Rails server: `rails server`.
6. You can now access the API endpoints and begin managing products in your retail application.

## Made with ❤️️ in ATX

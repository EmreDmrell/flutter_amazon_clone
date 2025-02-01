<div align='center'>

<h1>Task Management Application</h1>
<p>A full-stack Amazon clone built with Flutter and Node.js that provides an end-to-end ecommerce experience.
</p>



</div>

# :notebook_with_decorative_cover: Table of Contents

- [About the Project](#star2-about-the-project)
- [Contributing](#wave-contributing)


## :star2: About the Project
### :space_invader: Tech Stack
<details> <summary>Frontend</summary> <ul>
  <li><img src="https://img.shields.io/badge/Flutter-3.6%2B-blue"></li>
  <li><img src="https://img.shields.io/badge/State%20Management-Provider-blue"></li>
  <li><img src="https://img.shields.io/badge/Local%20Storage-Shared%20Preferences-blue"></li>
  <li><img src="https://img.shields.io/badge/HTTP%20Client-API%20communication-blue"></li>
  <li><img src="https://img.shields.io/badge/Connectivity%20Plus-network%20status-blue"></li>
</ul> </details>
<details> <summary>Backend</summary> <ul>
  <li><img src="https://img.shields.io/badge/Node.js-green"></li>
  <li><img src="https://img.shields.io/badge/Environment%20Configuration-support-green"></li>
  <li><img src="https://img.shields.io/badge/Database-MongoDB-green"></li>
  <li><img src="https://img.shields.io/badge/Image%20Storage-Claudinary-green"></li>
  <li><img src="https://img.shields.io/badge/Authentication-JWT-white"></li>
</ul> </details>


### :dart: Features

- 📱 Cross-platform support (iOS, Android, Web)
- 🔐 User Authentication (Sign up/Sign in)
- 👤 User & Admin Panels
- 🛍️ Product Management
  - Add/Edit/Delete products (Admin)
  - View products
  - Search products
  - Filter by category
- 🛒 Shopping Cart
  - Add/Remove items
  - Adjust quantities
- 💳 Payment Integration
  - Apple Pay
  - Google Pay
- 📦 Order Management
  - Place orders
  - Track order status
  - Order history
- ⭐ Product Ratings & Reviews
  
## :toolbox: Getting Started

### :bangbang: Prerequisites

- Flutter SDK
- Node.js (v16 or higher)
- MongoDB account
- Cloudinary Account
- Payment Configuration (Apple Pay/Google Pay)
- Vercel account (for deployment)
  
### :key: Environment Variables
To run this project, you will need to add the following environment variables to your .env file

`CLOUDINARY_NAME=your_cloudinary_name`
`UPLOAD_PRESET=your_upload_preset`
`HOME_IP_ADDRESS=your_backend_url`

#Server Deployment
`PORT=3000`
`MONGO_DB_URI=your_mongodb_connection_string`
`JWT_KEY=your_jwt_secret_key`
`SALT_ROUND=your_salt_round`


### :gear: Installation

Clone the repository
```bash
git clone https://github.com/EmreDmrell/task-manager.git 
```

### Local Developement
Navigate to the server directory
```bash
cd server
```

Install dependencies
```bash
npm install
```

### :running: Run the application:

Navigate to the root directory:
```bash
cd ..
```

Install Flutter dependencies:
```bash
flutter pub get
```
```bash
flutter run
```

### :file_cabinet: Project Structure

```plaintext
lib/
├── common/          # Common widgets and utilities
├── constants/       # Application constants
├── features/        # Feature modules
│   ├── admin/       # Admin panel features
│   ├── auth/        # Authentication
│   └── home/        # Home screen features
├── models/          # Data models
├── providers/       # State management
└── services/        # API services
```

## :wave: Contributing

1. Fork the repository
2. Create your feature branch:
    ```bash
    git checkout -b feature/AmazingFeature
    ```
3. Commit your changes:
    ```bash
    git commit -m 'Add some AmazingFeature'
    ```
4. Push to the branch:
    ```bash
    git push origin feature/AmazingFeature
    ```
5. Open a Pull Request
   
Contributions are always welcome!

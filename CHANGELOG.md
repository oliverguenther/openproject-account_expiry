## 0.1.0 (unreleased)

Features:


  - Add an `expiration_date` to the user model
  - Listen to OmniAuth Authorization ``user_login`` hook and the application's ``successful_authentication`` hook
  - Resets the expirations on every date
  - Overwrites the UsersHelper function `full_user_status` when the user is active and has an expiration date
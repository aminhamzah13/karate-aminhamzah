Feature: petstore user API Test

  Background:
    * url baseURL

  Scenario: Create a new user
    Given path 'user'
    And request { "id": 1, "username": "aminhamzah", "firstName": "Amin", "lastName": "Hamzah", "email": "aminhamzah@email.com", "password": "p455w0rd", "phone": "123456789", "userStatus": 1 }
    When method POST
    Then status 200

  Scenario: Get user by username
    Given path 'user/aminhamzah'
    When method GET
    Then status 200
    And match response == { "id": 1, "username": "aminhamzah", "firstName": "Amin", "lastName": "Hamzah", "email": "aminhamzah@email.com", "password": "p455w0rd", "phone": "123456789", "userStatus": 1 }

  Scenario: Log in user
    Given path 'user/login'
    And request { "username": "aminhamzah", "password": "p455w0rd" }
    When method GET
    Then status 200

  Scenario: Log out current logged in user session
    Given path 'user/logout'
    When method GET
    Then status 200
    And match response == { "code": 200, "type": "unknown", "message": "ok" }

  Scenario: Delete user
    Given path 'user/aminhamzah'
    When method DELETE
    Then status 200

  Scenario: Verify user deletion
    Given path 'user/aminhamzah'
    When method GET
    Then status 404
    And match response == { "code": 1, "type": "error", "message": "User not found" }

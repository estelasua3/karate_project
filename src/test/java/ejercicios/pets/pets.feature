Feature: Pet test suite

  Background:
    * url 'https://petstore.swagger.io/v2'

  Scenario: Validate creating new pet
    * def postPet = read('data/postPet.json')

    Given path '/pet'
    And request postPet
    When method post
    Then status 200
    And match $.status == 'available'

  Scenario: Validate updating existing pet
    * def putPet = read('data/putPet.json')

    Given path '/pet'
    And request putPet
    When method put
    Then status 200
    And match $.name == 'perrin'

    * def putResponse = $

  Scenario: Validate searching for pets by status
    Given path 'pet/findByStatus'
    And param status = 'available'
    When method get
    Then status 200
    And match $[0].status == 'available'

  Scenario: Validate removing for pets by status
    * def petId = 55556
    Given path 'pet', petId
    When method delete
    Then status 200

    Given path 'pet', petId
    When method get
    Then status 404
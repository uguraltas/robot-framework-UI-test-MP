*** Settings ***
Suite Teardown    Close All Browsers
Test Teardown     Take Screenshot If Test Fails And Close Browser
Resource          ../../Resources/Variables.robot
Resource          ../../Facilities/MainKeywords.robot
Library           SeleniumLibrary

*** Test Cases ***
TC001.Go to the pet shop page from the categories section and sort the products by lowest price first
    Given I open new browser  ${migros_url}  ${browser}  #  URL = https://www.migros.com.tr/ - Browser = Chrome
    When I go to the pet shop page from the categories section
    Then I will see url as   https://www.migros.com.tr/pet-shop-c-a0
    And I Will See Page Contains   Pet Shop
    When I sorting as   ${first_lowest_price}
    Then I see that the order of the products is correct

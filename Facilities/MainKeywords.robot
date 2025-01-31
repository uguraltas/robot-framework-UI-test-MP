*** Settings ***
Library    SeleniumLibrary  run_on_failure=NOTHING
Library  Collections

*** Keywords ***
I Open New Browser
    [Arguments]    ${url}  ${brw}
    Open Browser    ${url}    ${brw}
    Maximize Browser Window

Click On Element
    [Arguments]    ${element}
    Wait For Element    ${element}
    Wait Until Element Is Not Visible    ${loading}     10s
    Click Element    ${element}

Wait For Element
    [Arguments]    ${element}
    Wait Until Keyword Succeeds    10 sec    0.1 sec    Element Should Be Enabled    ${element}

Wait And Over Element
    [Arguments]    ${element}
    Wait For Element    ${element}
    Mouse Over    ${element}

Accept Cookies and Close Popover
    Click On Element    ${close_popover}
    Click On Element    ${accept_cookies}

Take Screenshot If Test Fails And Close Browser
    Run Keyword If Test Failed    Save Screenshot With Test Name
    Close All Browsers

Save Screenshot With Test Name
    ${test_name}    Replace String    ${TEST NAME}    ${SPACE}    _
    ${screenshot_dir}    Set Variable    ${OUTPUT DIR}/screenshots
    Create Directory    ${screenshot_dir}
    ${filename}    Set Variable    ${screenshot_dir}/${test_name}.png
    Capture Page Screenshot    ${filename}
    Log    Screenshot saved as ${filename}

I Go to the Pet Shop Page From The Categories Section
    Accept Cookies and Close Popover
    Wait And Over Element   ${categories}
    Wait For Element   ${petshop}
    ${element}    Get WebElement    ${petshop}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}    Click On Element    ${element}

I Will See Url As
    [Arguments]    ${url}
    Location Should Be    ${url}
    Wait Until Element Is Not Visible    ${loading}     10s

I Will See Page Contains
    [Arguments]    ${text}
    Wait Until Page Contains    ${text}    5s

I Sorting As
    [Arguments]    ${sort_type}
    Wait And Over Element   ${sort}
    Click On Element   ${sort}
    Click On Element   ${sort_type}
    Wait Until Element Is Not Visible    ${loading}     10s

I Will See Element text Should Be Equal As
    [Arguments]    ${item}   ${name}
    ${text}    Get Text    ${item}
       Should Be Equal As Strings    ${text}   ${name}

I See That The Order Of The Products Is Correct
    ${prices}  Get WebElements  ${price_locator}
    ${price_values}  Create List

    FOR  ${price}  IN  @{prices}
          ${text}  Get Text  ${price}
          ${clean_text}  Evaluate  '${text}'.replace(' TL', '').replace(',', '.')
          ${clean_price}  Evaluate  float(${clean_text})
          Append To List  ${price_values}  ${clean_price}
    END
    ${sorted_prices}  Copy List  ${price_values}
    Sort List  ${sorted_prices}

    Should Be Equal  ${price_values}  ${sorted_prices}  Ürünler beklendiğiyanlış sıralanmış!


# Load Cookies or local/session storage for Location data and pop-ups etc
Cookie and Stroge Setting
      [Arguments]    ${url}
      ${cookies}=    Get File    ${cookie_file}
      ${cookies_json}=    Evaluate      json.loads('''${cookies}''')
      FOR    ${cookie}    IN    @{cookies_json}
          Add Cookie    name=${cookie['name']}    value=${cookie['value']}    domain=${cookie['domain']}    path=${cookie['path']} expires=${cookie['expires']}    secure=${cookie['secure']}
      END
      Go To   ${url}
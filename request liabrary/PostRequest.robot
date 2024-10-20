*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    String
Library    Collections
Documentation    Robot Framework API Testing with POST Request

*** Keywords ***


*** Variables ***
${base_url}             https://reqres.in/
${post_endpoint}        /api/users
${user_data}            {"name": "morpheus", "job": "leader"}
${endpoint_login}     /api/login


*** Test Cases ***
Send Post Request
    Create Session    mysession    ${base_url}    disable_warnings=1
    ${response}    Post Request    mysession    ${post_endpoint}    data=${user_data}
#Valiadations
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    201
    ${json_response}    Convert String to JSON    ${response.content}
    Log    ${json_response}
    ${createdAt}    Get Value From Json    ${json_response}    $.createdAt
    ${res_createdAt}    Convert To String    ${createdAt}
    ${contents}    Remove String Using Regexp    ${res_createdAt}    ['\\[\\],]
    Log    ${contents}
    Should Contain    ${contents}    2024-10-20T
    ${id}    Get Value From Json    ${json_response}    $.id
    Log    ${id}
    Should Not Be Empty    ${id}


Register User login successful 
    Create Session    session1    ${base_url}      disable_warnings=True
    ${endpoint_register}    Set Variable    /api/login    
    ${body}    Create Dictionary    email=eve.holt@reqres.in    password=cityslicka
    ${response}    POST On Session    session1    ${endpoint_register}    data=${body}
    Log To Console    ${response.status_code}    
    Log To Console    ${response.content}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json_response}    Convert String to JSON    ${response.content}
    Log    ${json_response}
    ${token}    Get Value From Json    ${json_response}    $.token
    ${token}    Convert To String    ${token}
    ${contents}    Remove String Using Regexp    ${token}    ['\\[\\],]
    Log    ${contents}
    Should Be Equal   ${contents}    QpwL5tke4Pnpja7X4



Register User Login Unsuccessful
    Create Session    session2    ${base_url}      disable_warnings=True
    ${body}    Create Dictionary    email=peter@klaven    password=
    ${result}       Run Keyword And Ignore Error     POST On Session    session2    ${endpoint_login}    
    Log To Console    ${result}    
    # ตรวจสอบผลลัพธ์ว่าเป็น 'FAIL'
    Should Be Equal As Strings    ${result}[0]    FAIL
     # ตรวจสอบข้อความข้อผิดพลาด
    ${response}    Set Variable    ${result}[1]
    Log To Console    ${response}
   
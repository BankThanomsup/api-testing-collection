*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    String
Library    Collections
Documentation    Robot Framework API Testing with GET Request

*** Keywords ***


*** Variables ***
${base_url}    https://reqres.in/
${page_path}    $.page
${page_single_user}    $.data.id
${page_single_not_found}    $
${page_user_resouce_not_found}    $
${page_user_resouce}    $.data[0].name
${endpoint_list_users}    /api/users?page=2
${endpoint_single_user}    /api/users/2
${endpoint_user_not_found}    /api/users/23
${endpoint_user_resouce}    /api/unknown
${endpoint_user_resouce_not_found}    /api/unknown/23
                



*** Test Cases ***
Request List users
# สร้าง session ชื่อ mysession เพื่อใช้งานในคำขอ HTTP อื่น ๆ
    Create Session    mysession    ${base_url}    disable_warnings=1

# ส่ง GET request ไปยัง endpoint "/api/users?page=2"
    ${response}    Get Request    mysession    ${endpoint_list_users}
    Log    ${response.status_code}
    Log    ${response.content}
    ${json_response}    Convert String to JSON    ${response.content}
    Log To Console    ${json_response} 
#Valiadations
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${contents}    Get Value From Json    ${json_response}    ${page_path}
    Log To Console    ${contents}
    ${contents}    Convert To String    ${contents}    
    ${contents}    Remove String Using Regexp    ${contents}    ['\\[\\],]
    Log To Console    ${contents}
    Should Be Equal   ${contents}    2

    ${headerValue}    Get From Dictionary   ${response.headers}    Content-Type
    Should Be Equal   ${headerValue}    application/json; charset=utf-8

    
Request Single user
    Create Session    mysession    ${base_url}
    ${response}    Get Request    mysession    ${endpoint_single_user}
    Log    ${response.status_code}
    Log    ${response.content}  
# แปลง response ให้เป็น JSON และแสดงผล
    ${json_response}    Convert String to JSON    ${response.content}    
    Log To Console    ${json_response}  
#Valiadations   
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${contents}    Get Value From Json    ${json_response}    ${page_single_user}
    Log To Console    ${contents}
    ${contents}    Convert To String    ${contents}    
    ${contents}    Remove String Using Regexp    ${contents}    ['\\[\\],]
    Log To Console    ${contents}
    Should Be Equal   ${contents}    2

    ${headerValue}    Get From Dictionary   ${response.headers}    Content-Type
    Should Be Equal   ${headerValue}    application/json; charset=utf-8

Request Single user
    Create Session    mysession    ${base_url}
    ${response}    Get Request    mysession    ${endpoint_user_not_found}
    Log    ${response.status_code}
    Log    ${response.content}  
# แปลง response ให้เป็น JSON และแสดงผล
    ${json_response}    Convert String to JSON    ${response.content}    
    Log To Console    ${json_response}  
#Valiadations   
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    404
    ${contents}    Get Value From Json    ${json_response}    ${page_single_not_found}
    Log To Console    ${contents}
    ${contents}    Convert To String    ${contents}    
    ${contents}    Remove String Using Regexp    ${contents}    ['\\[\\],]
    Log To Console    ${contents}
    Should Be Equal   ${contents}    {}

    ${headerValue}    Get From Dictionary   ${response.headers}    Content-Type
    Should Be Equal   ${headerValue}    application/json; charset=utf-8


Request list resource
    Create Session    mysession    ${base_url}
    ${response}    Get Request    mysession    ${endpoint_user_resouce}
    Log    ${response.status_code}
    Log    ${response.content}  
# แปลง response ให้เป็น JSON และแสดงผล
    ${json_response}    Convert String to JSON    ${response.content}    
    Log To Console    ${json_response}  
#Valiadations   
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    ${contents}    Get Value From Json    ${json_response}    ${page_user_resouce}
    Log To Console    ${contents}
    ${contents}    Convert To String    ${contents}    
    ${contents}    Remove String Using Regexp    ${contents}    ['\\[\\],]
    Log To Console    ${contents}
    Should Be Equal   ${contents}    cerulean

    ${headerValue}    Get From Dictionary   ${response.headers}    Content-Type
    Should Be Equal   ${headerValue}    application/json; charset=utf-8

Request list resource not found
    Create Session    mysession    ${base_url}
    ${response}    Get Request    mysession    ${endpoint_user_resouce_not_found}
    Log    ${response.status_code}
    Log    ${response.content}  
# แปลง response ให้เป็น JSON และแสดงผล
    ${json_response}    Convert String to JSON    ${response.content}    
    Log To Console    ${json_response}  
#Valiadations   
    ${status_code}    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    404
    ${contents}    Get Value From Json    ${json_response}    ${page_user_resouce_not_found}
    Log To Console    ${contents}
    ${contents}    Convert To String    ${contents}    
    ${contents}    Remove String Using Regexp    ${contents}    ['\\[\\],]
    Log To Console    ${contents}
    Should Be Equal   ${contents}    {}

    ${headerValue}    Get From Dictionary   ${response.headers}    Content-Type
    Should Be Equal   ${headerValue}    application/json; charset=utf-8




*** Settings ***
Library               RequestsLibrary
Library    JSONLibrary
Documentation    Robot framework Demo


*** Keywords ***


*** Variables ***
${base_url}    https://reqres.in/
${endpoint}    /api/users?page=2



*** Test Cases ***
Request List users


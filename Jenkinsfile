#!groovy

import groovy.json.JsonSlurperClassic

node {

    def SF_CONSUMER_KEY=env.SF_CONSUMER_KEY
    def SF_USERNAME=env.SF_USERNAME
    def SERVER_KEY_CREDENTALS_ID=env.SERVER_KEY_CREDENTALS_ID
    def TEST_LEVEL='RunLocalTests'
    def PACKAGE_NAME='0Ho1U000000CaUzSAK'
    def PACKAGE_VERSION
    def SF_INSTANCE_URL = env.SF_INSTANCE_URL ?: "https://login.salesforce.com"

    def toolbelt = tool 'toolbelt'


    // -------------------------------------------------------------------------
    // Check out code from source control.
    // -------------------------------------------------------------------------

    stage('checkout source') {
        checkout scm
    }


    // -------------------------------------------------------------------------
    // Run all the enclosed stages with access to the Salesforce
    // JWT key credentials.
    // -------------------------------------------------------------------------
    
    withEnv(["HOME=${env.WORKSPACE}"]) {
        
        withCredentials([file(credentialsId: SERVER_KEY_CREDENTALS_ID, variable: 'server_key_file')]) {

            // -------------------------------------------------------------------------
            // Authorize the Dev Hub org with JWT key and give it an alias.
            // -------------------------------------------------------------------------

            stage('Authorize DevHub') {
                rc = command "${toolbelt}/sfdx force:auth:jwt:grant --instanceurl ${SF_INSTANCE_URL} --clientid ${SF_CONSUMER_KEY} --username ${SF_USERNAME} --jwtkeyfile ${server_key_file} --setdefaultdevhubusername --setalias HubOrg"
                if (rc != 0) {
                    error 'Salesforce dev hub org authorization failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Create new scratch org to test your code.
            // -------------------------------------------------------------------------

            stage('Create Test Scratch Org') {
                rc = command "${toolbelt}/sfdx force:org:create --targetdevhubusername HubOrg --setdefaultusername --definitionfile config/project-scratch-def.json --setalias ciorg --wait 10 --durationdays 1"
                if (rc != 0) {
                    error 'Salesforce test scratch org creation failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Display test scratch org info.
            // -------------------------------------------------------------------------

            stage('Display Test Scratch Org') {
                rc = command "${toolbelt}/sfdx force:org:display --targetusername ciorg"
                if (rc != 0) {
                    error 'Salesforce test scratch org display failed.'
                }
            }


            // -------------------------------------------------------------------------
            // Push source to test scratch org.
            // -------------------------------------------------------------------------

            stage('Push To Test Scratch Org') {
                rc = command "${toolbelt}/sfdx force:source:push --targetusername ciorg"
                if (rc != 0) {
                    error 'Salesforce push to test scratch org failed.'
                }
            }
        }
    }
}

def command(script) {
    if (isUnix()) {
        return sh(returnStatus: true, script: script);
    } else {
        return bat(returnStatus: true, script: script);
    }
}

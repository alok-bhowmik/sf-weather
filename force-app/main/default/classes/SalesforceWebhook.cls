@RestResource(urlMapping='/whatsapp/webhooks/v1/*')
global class SalesforceWebhook {

    Private static Final String SIGNATURE_VALID_MESSAGE = 'Signature Verified';
    Private static Final String SIGNATURE_NOT_VALID_MESSAGE = 'Signature could not be Verified';
    
    @HttpGet
    Global static void doGet(){
        RestResponse response = RestContext.response;
        RestRequest request = RestContext.request;
        
        if(request.params.get('hub.verify_token') == 'WHATSAPPTOKEN'){
            response.responseBody = Blob.valueOf(request.params.get('hub.challenge'));
        }
    }
}
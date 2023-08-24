public class WhatsappController {

     @AuraEnabled
    Public static Boolean sendTamplateMessage(String contactId){
        
        Contact contactDetail =[Select Id,Phone From Contact Where Id=:contactId];
        String whatsappNumber = '91' +contactDetail.Phone;
        System.debug('whatsappNumber-->'+whatsappNumber);
        
        Http http = new Http();
        HttpRequest req= new HttpRequest();

        
        req.setEndpoint('https://graph.facebook.com/v16.0/106666942402862/messages');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        
      //  String body= '{"Messaging_product", "whatsapp", "to":"'+whatsappNumber+'", "type": "template", "template": {"name": "sfnoob_alert","language": {"code": "en_US"}}}';
       
        String body1 ='{ \"messaging_product\": \"whatsapp\", "to":"'+whatsappNumber+'", \"type\": \"template\", \"template\": { \"name\": \"hello_world\", \"language\": { \"code\": \"en_US\" } } }';
        System.debug('body1-->'+body1);
        
        req.setBody(body1);
        String apiToken = 'EAAHqCT2PRZA8BABpc2QJQcZCw6Ju5oPgKpqoo4SmGf149TrEfWkh7bJg5qvxZC0ShIqeEoGm1HwyNuaNF8rL8tPyr9JA1ZB4qC3ZCaxA1VPZAi61X51HkPl7vZCeO4VNxkH6UwNgxpP1yJjvrhI56gZCLxEkZCxUkUNEuG57hwTLLBgk34Sk7hfqgP54e731jkjej4fhAyZCAI1QZDZD';
        req.setHeader('Authorization', 'Bearer '+apiToken);
        
        HttpResponse res = http.send(req);
        System.debug('response-->'+res.getBody());
        System.debug('getStatusCode-->'+res.getStatusCode());
        
        if(res.getStatusCode()==200){
            return true;
        }
          return false;
    }
}
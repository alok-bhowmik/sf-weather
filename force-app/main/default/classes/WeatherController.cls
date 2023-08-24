/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 08-23-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class WeatherController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getWeatherInfo(String cityName) {
        String apiKey = 'd27d93ae83deaa5e6a64bd66e655d3b0';
        String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?q=' + EncodingUtil.urlEncode(cityName, 'UTF-8') + '&units=metric&appid=' + apiKey;
        System.debug('apiUrl-->'+apiUrl);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(apiUrl);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('response-->'+response);
        if (response.getStatusCode() == 200) {
            return (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
           
        }
        return null;
    }
}

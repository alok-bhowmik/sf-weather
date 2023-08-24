// import { LightningElement } from 'lwc';

// export default class WeatherChildComponent extends LightningElement {}
import { LightningElement, api, track } from 'lwc';

export default class WeatherChildComponent extends LightningElement {
    @api cityName;

    @track currentTemperature = '';
    @track weatherDescription = '';
    @track weatherIcon = '';
    @track iconUrl = '';

    connectedCallback() {
        this.fetchWeatherData();
    }

    fetchWeatherData() {
        // Replace with your actual API endpoint
        const apiKey = 'd27d93ae83deaa5e6a64bd66e655d3b0';
        const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${this.cityName}&units=metric&appid=${apiKey}`;
        console.log('apiUrl-->', apiUrl);

        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                this.currentTemperature = data.main.temp;
                this.weatherDescription = data.weather[0].description;
                this.weatherIcon = data.weather[0].icon;
                this.iconUrl = `https://openweathermap.org/img/w/${this.weatherIcon}.png`;
            })
            .catch(error => {
                console.error('Error fetching weather data:', error);
            });
    }
}

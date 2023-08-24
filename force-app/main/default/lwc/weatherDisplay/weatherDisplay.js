// import { LightningElement, track } from 'lwc';

// export default class WeatherDisplay extends LightningElement {
// }
import { LightningElement, track } from 'lwc';
import getWeatherInfo from '@salesforce/apex/WeatherController.getWeatherInfo';

export default class WeatherDisplay extends LightningElement {
    @track cityName = '';
    @track weatherData;
    

    handleCityChange(event) {
        this.cityName = event.target.value;
        this.fetchWeatherData();
    }

    async fetchWeatherData() {
        try {
            this.weatherData = await getWeatherInfo({ cityName: this.cityName });
            console.log('Weather Data:', this.weatherData);
        } catch (error) {
            console.error('Error fetching weather data:', error);
        }
        
    }
    

    getWeatherIconUrl(iconCode) {
        return `https://openweathermap.org/img/w/${iconCode}.png`;
    }

    get weatherDescription() {
        return this.weatherData ? this.weatherData.weather[0].description : '';
    }

    get weatherIcon() {
        return this.weatherData ? this.getWeatherIconUrl(this.weatherData.weather[0].icon) : '';
    }
    // get weatherHumidity() {
    //     return this.weatherData ? this.weatherData.weather[0].humidity : '';
    // }
}

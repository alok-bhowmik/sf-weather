import { LightningElement } from 'lwc';
export default class VigneshComponent extends LightningElement {
    connectedCallback() {
        console.log('in connected call back')
        fetch('https://cabinetworksgroup.com/ops-status', {method:'GET'}).then(
            responce =>{
            console.log('response -->'. responce)
        }).catch(error =>{
            console.log('error -->', error)
        })
    }
}
import { Controller } from '@hotwired/stimulus';

import Chart from 'highcharts/es-modules/Core/Chart/Chart.js';
import LineSeries from 'highcharts/es-modules/Series/Line/LineSeries.js';


export default class extends Controller {
    connect() {
        const myChart = new Chart('container', {
            series: [{
                type: 'line',
                data: [1, 2, 3]
            }]
        });
    }
}
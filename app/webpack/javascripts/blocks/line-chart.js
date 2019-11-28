up.compiler('.line-chart', function (line_chart) {
    $line_chart = $(line_chart)


    let ctx = $line_chart.find('.line-chart--chart')[0].getContext('2d')
    let dataUrl = $line_chart.attr('data-url')
    let dataLabel = $line_chart.attr('data-label')
    let scope = 'day'

    let lineChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: [{
                label: dataLabel,
                data: [],
                backgroundColor: 'rgba(0,64,255,0.47)',
                borderColor: 'rgba(0,64,255,0.47)'
            }]
        },
        options: {
            spanGaps: true
        }
    });

    function updateChart(url, chart){
        $.getJSON( url, function( data ) {
            chart.data.labels = data.labels
            chart.data.datasets[0].data = data.values
            chart.update()
        });
    }

    setInterval(function(){
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    }, 60000);

    function highlightButton (button){
        $line_chart.find('.line-chart--interval-buttons button').each(function (){
            if(button == this){
                $(this).removeClass('btn-secondary')
                $(this).addClass('btn-primary')
            } else {
                $(this).addClass('btn-secondary')
                $(this).removeClass('btn-primary')
            }
        })
    }

    updateChart(dataUrl + '.json?interval=' + scope, lineChart)

    $line_chart.find('#select_hour').click(function (){
        highlightButton(this)
        scope = 'hour'
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    })

    $line_chart.find('#select_3hour').click(function (){
        highlightButton(this)
        scope = '3hour'
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    })

    $line_chart.find('#select_day').click(function (){
        highlightButton(this)
        scope = 'day'
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    })

    $line_chart.find('#select_week').click(function (){
        highlightButton(this)
        scope = 'week'
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    })

    $line_chart.find('#select_month').click(function (){
        highlightButton(this)
        scope = 'month'
        updateChart(dataUrl + '.json?interval=' + scope, lineChart)
    })





})

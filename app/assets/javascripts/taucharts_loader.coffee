jQuery ->
  $('.remote-chart').each (index, element) ->
    data_url = $(element).data('url')
    $.getJSON data_url, (data) ->
      chart = new tauCharts.Chart
        data: data
        type: 'line'
        x: 'time'
        y: 'mean'
        dimensions:
          mean:
            type: 'measure'
          time:
            type: 'measure'
            scale: 'time'


      chart.renderTo(element)
